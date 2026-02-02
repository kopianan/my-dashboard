import 'dart:async';
import 'package:dynamic_dashboard/infrastructure/models/stock_price/stock_price_model.dart';

abstract class StockPriceWebSocketDataSource {
  /// Stream of stock price updates
  Stream<StockPriceResponseModel> get stockPriceStream;
  
  /// Connection state stream
  Stream<WebSocketConnectionState> get connectionStateStream;
  
  /// Connect to WebSocket
  Future<void> connect();
  
  /// Disconnect from WebSocket
  Future<void> disconnect();
  
  /// Pause connection (for background mode)
  Future<void> pause();
  
  /// Resume connection (from background mode)
  Future<void> resume();
  
  /// Subscribe to a specific symbol
  Future<void> subscribeToSymbol(String symbol);
  
  /// Subscribe to multiple symbols
  Future<void> subscribeToSymbols(List<String> symbols);
  
  /// Unsubscribe from a symbol
  Future<void> unsubscribeFromSymbol(String symbol);
  
  /// Check if connected
  bool get isConnected;
  
  /// Check if paused
  bool get isPaused;
  
  /// Get currently subscribed symbols
  Set<String> get subscribedSymbols;
  
  /// Dispose resources
  void dispose();
}

enum WebSocketConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
  paused,
}