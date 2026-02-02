import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/stock_price/stock_price_model.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@Injectable(as: StockPriceWebSocketDataSource)
class StockPriceWebSocketDataSourceImpl
    implements StockPriceWebSocketDataSource {
  StockPriceWebSocketDataSourceImpl(this.appConfig);  
  
  final AppConfig appConfig;
  static const Duration _reconnectDelay = Duration(seconds: 5);
  static const int _maxReconnectAttempts = 5;

  // Default symbols to subscribe
  static const List<String> _defaultSymbols = [
    'BINANCE:BTCUSDT',
    'BINANCE:ETHUSDT',
    'BINANCE:SOLUSDT',
    'BINANCE:XRPUSDT',
  ];

  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  int _reconnectAttempts = 0;
  bool _isDisposed = false;

  // Streams and controllers
  final StreamController<StockPriceResponseModel> _stockPriceController =
      StreamController<StockPriceResponseModel>.broadcast();
  final StreamController<WebSocketConnectionState> _connectionStateController =
      StreamController<WebSocketConnectionState>.broadcast();

  // State tracking
  WebSocketConnectionState _currentState =
      WebSocketConnectionState.disconnected;
  final Set<String> _subscribedSymbols = <String>{};
  bool _isPaused = false;

  @override
  Stream<StockPriceResponseModel> get stockPriceStream =>
      _stockPriceController.stream;

  @override
  Stream<WebSocketConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  @override
  bool get isConnected => _currentState == WebSocketConnectionState.connected || 
                         _currentState == WebSocketConnectionState.paused;

  @override
  bool get isPaused => _isPaused;

  @override
  Set<String> get subscribedSymbols =>
      Set<String>.unmodifiable(_subscribedSymbols);

  @override
  Future<void> connect() async {
    if (_isDisposed || isConnected || _currentState == WebSocketConnectionState.connecting) {
      developer.log('Skipping connect - already connected or connecting', name: 'StockPriceWS');
      return;
    }

    _setConnectionState(WebSocketConnectionState.connecting);

    try {
      final wsUrl = appConfig.finnhubWsUrlWithToken;
      developer.log('Connecting to WebSocket: $wsUrl', name: 'StockPriceWS');

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // Listen to WebSocket messages
      _channel!.stream.listen(
        _handleWebSocketMessage,
        onError: _handleWebSocketError,
        onDone: _handleWebSocketDone,
        cancelOnError: false,
      );

      // Give the connection a moment to establish
      await Future.delayed(const Duration(milliseconds: 500));

      // Check if connection was closed immediately
      if (_isDisposed || _currentState == WebSocketConnectionState.disconnected) {
        throw Exception('Connection failed to establish');
      }

      // Connection is established
      _setConnectionState(WebSocketConnectionState.connected);

      developer.log('WebSocket connected successfully', name: 'StockPriceWS');

      // Wait a bit before subscribing to let the connection fully establish
      Timer(const Duration(seconds: 2), () async {
        if (isConnected && !_isDisposed) {
          developer.log('Starting symbol subscriptions', name: 'StockPriceWS');
          await subscribeToSymbols(_defaultSymbols);
          
          // Only reset reconnect attempts after successful subscription
          _reconnectAttempts = 0;
        }
      });

      // Start heartbeat after a longer delay to ensure subscriptions are processed
      Timer(const Duration(seconds: 10), () {
        if (isConnected && !_isDisposed) {
          _startHeartbeat();
        }
      });

    } catch (e) {
      developer.log('WebSocket connection failed: $e', name: 'StockPriceWS');
      _setConnectionState(WebSocketConnectionState.error);
      _scheduleReconnect();
    }
  }

  @override
  Future<void> disconnect() async {
    developer.log('Disconnecting WebSocket', name: 'StockPriceWS');

    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();

    try {
      await _channel?.sink.close();
    } catch (e) {
      developer.log('Error closing WebSocket: $e', name: 'StockPriceWS');
    }

    _channel = null;
    _subscribedSymbols.clear();
    _setConnectionState(WebSocketConnectionState.disconnected);
  }

  @override
  Future<void> pause() async {
    if (_isPaused || !isConnected) return;

    developer.log('Pausing WebSocket connection', name: 'StockPriceWS');

    _isPaused = true;
    _heartbeatTimer?.cancel();
    _setConnectionState(WebSocketConnectionState.paused);

    // Keep connection alive but stop heartbeat to save resources
    // Don't actually close the connection for faster resume
    developer.log('WebSocket paused - keeping connection alive', name: 'StockPriceWS');
  }

  @override
  Future<void> resume() async {
    if (!_isPaused) return;

    developer.log('Resuming WebSocket connection', name: 'StockPriceWS');

    _isPaused = false;

    // Check if the connection is still alive
    if (isConnected) {
      // Connection is still active, just resume processing
      _setConnectionState(WebSocketConnectionState.connected);
      _startHeartbeat();

      developer.log('WebSocket resumed - connection was still active', name: 'StockPriceWS');
    } else {
      // Connection was lost during pause, reconnect
      developer.log('WebSocket connection lost during pause, reconnecting', name: 'StockPriceWS');
      await connect();
    }
  }

  @override
  Future<void> subscribeToSymbol(String symbol) async {
    if (!isConnected || _subscribedSymbols.contains(symbol)) return;

    try {
      final subscribeMessage = json.encode({
        'type': 'subscribe',
        'symbol': symbol,
      });

      _channel!.sink.add(subscribeMessage);
      _subscribedSymbols.add(symbol);

      developer.log('Subscribed to symbol: $symbol', name: 'StockPriceWS');

      // Small delay between subscriptions to avoid rate limiting
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      developer.log('Failed to subscribe to $symbol: $e', name: 'StockPriceWS');
    }
  }

  @override
  Future<void> subscribeToSymbols(List<String> symbols) async {
    for (final symbol in symbols) {
      await subscribeToSymbol(symbol);
      // Small delay between subscriptions to avoid overwhelming the server
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  Future<void> unsubscribeFromSymbol(String symbol) async {
    if (!isConnected || !_subscribedSymbols.contains(symbol)) return;

    try {
      final unsubscribeMessage = json.encode({
        'type': 'unsubscribe',
        'symbol': symbol,
      });

      _channel!.sink.add(unsubscribeMessage);
      _subscribedSymbols.remove(symbol);

      developer.log('Unsubscribed from symbol: $symbol', name: 'StockPriceWS');
    } catch (e) {
      developer.log(
        'Failed to unsubscribe from $symbol: $e',
        name: 'StockPriceWS',
      );
    }
  }

  void _handleWebSocketMessage(dynamic message) {
    // Skip processing if paused to save resources
    if (_isPaused) return;

    try {
      final data = json.decode(message as String) as Map<String, dynamic>;

      // Handle different message types
      switch (data['type']) {
        case 'trade':
          if (data['data'] != null) {
            final stockPriceResponse = StockPriceResponseModel.fromJson(data);
            _stockPriceController.add(stockPriceResponse);
          }
          break;
        case 'error':
          developer.log('Server error: ${data['msg']}', name: 'StockPriceWS');
          break;
        case 'ping':
          // Server ping, respond with pong
          _channel?.sink.add(json.encode({'type': 'pong'}));
          break;
        default:
          developer.log('Unknown message type: ${data['type']}', name: 'StockPriceWS');
      }
    } catch (e) {
      developer.log(
        'Failed to parse WebSocket message: $e',
        name: 'StockPriceWS',
      );
      developer.log('Raw message: $message', name: 'StockPriceWS');
    }
  }

  void _handleWebSocketError(dynamic error) {
    developer.log('WebSocket error: $error', name: 'StockPriceWS');
    _setConnectionState(WebSocketConnectionState.error);
    _scheduleReconnect();
  }

  void _handleWebSocketDone() {
    developer.log('WebSocket connection closed', name: 'StockPriceWS');
    
    // Log additional info for debugging
    if (_channel != null) {
      developer.log('WebSocket close code: ${_channel!.closeCode}', name: 'StockPriceWS');
      developer.log('WebSocket close reason: ${_channel!.closeReason}', name: 'StockPriceWS');
    }
    
    if (!_isDisposed &&
        _currentState != WebSocketConnectionState.disconnected) {
      _setConnectionState(WebSocketConnectionState.disconnected);
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed || _reconnectAttempts >= _maxReconnectAttempts) {
      developer.log(
        'Max reconnect attempts reached or disposed',
        name: 'StockPriceWS',
      );
      return;
    }

    _reconnectTimer?.cancel();
    _reconnectAttempts++;

    developer.log(
      'Scheduling reconnect attempt $_reconnectAttempts in ${_reconnectDelay.inSeconds}s',
      name: 'StockPriceWS',
    );

    _setConnectionState(WebSocketConnectionState.reconnecting);

    _reconnectTimer = Timer(_reconnectDelay, () {
      if (!_isDisposed) {
        connect();
      }
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    // Use a longer interval to be less aggressive
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 45), (timer) {
      if (isConnected && !_isPaused) {
        try {
          // Use a simpler ping format
          _channel!.sink.add('ping');
          developer.log('Heartbeat sent', name: 'StockPriceWS');
        } catch (e) {
          developer.log('Heartbeat failed: $e', name: 'StockPriceWS');
          // Don't immediately fail, the connection might recover
        }
      } else {
        // If not connected, cancel the heartbeat
        timer.cancel();
        _heartbeatTimer = null;
      }
    });
  }

  void _setConnectionState(WebSocketConnectionState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      if (!_connectionStateController.isClosed) {
        _connectionStateController.add(newState);
      }
    }
  }

  @override
  void dispose() {
    developer.log('Disposing WebSocket data source', name: 'StockPriceWS');

    _isDisposed = true;
    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();

    disconnect();

    _stockPriceController.close();
    _connectionStateController.close();
  }
}
