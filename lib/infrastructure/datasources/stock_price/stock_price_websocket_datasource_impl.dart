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
  bool get isConnected => _currentState == WebSocketConnectionState.connected;

  @override
  bool get isPaused => _isPaused;

  @override
  Set<String> get subscribedSymbols =>
      Set<String>.unmodifiable(_subscribedSymbols);

  @override
  Future<void> connect() async {
    if (_isDisposed || isConnected) return;

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

      // Set connected state
      _setConnectionState(WebSocketConnectionState.connected);
      _reconnectAttempts = 0;

      // Subscribe to default symbols
      await subscribeToSymbols(_defaultSymbols);

      // Start heartbeat
      _startHeartbeat();

      developer.log('WebSocket connected successfully', name: 'StockPriceWS');
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
  }

  @override
  Future<void> resume() async {
    if (!_isPaused) return;

    developer.log('Resuming WebSocket connection', name: 'StockPriceWS');

    _isPaused = false;

    if (isConnected) {
      _setConnectionState(WebSocketConnectionState.connected);
      _startHeartbeat();

      // Re-subscribe to all symbols
      final symbolsToResubscribe = List<String>.from(_subscribedSymbols);
      _subscribedSymbols.clear();
      await subscribeToSymbols(symbolsToResubscribe);
    } else {
      // Reconnect if connection was lost during pause
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

      // Check if this is a trade message
      if (data['type'] == 'trade' && data['data'] != null) {
        final stockPriceResponse = StockPriceResponseModel.fromJson(data);
        _stockPriceController.add(stockPriceResponse);
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
    _setConnectionState(WebSocketConnectionState.error);
    _scheduleReconnect();
  }

  void _handleWebSocketDone() {
    developer.log('WebSocket connection closed', name: 'StockPriceWS');
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
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (isConnected) {
        try {
          _channel!.sink.add(json.encode({'type': 'ping'}));
        } catch (e) {
          developer.log('Heartbeat failed: $e', name: 'StockPriceWS');
        }
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
