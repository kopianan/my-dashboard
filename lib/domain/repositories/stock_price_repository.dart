import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';

abstract class StockPriceRepository {
  /// Stream of real-time stock price updates
  Stream<Either<String, StockPriceResponse>> get stockPriceStream;
  
  /// Stream of connection state changes
  Stream<WebSocketConnectionState> get connectionStateStream;
  
  /// Start listening to stock price updates
  Future<Either<String, void>> startListening();
  
  /// Stop listening to stock price updates
  Future<Either<String, void>> stopListening();
  
  /// Pause listening (for background mode)
  Future<Either<String, void>> pauseListening();
  
  /// Resume listening (from background mode)
  Future<Either<String, void>> resumeListening();
  
  /// Subscribe to a specific symbol
  Future<Either<String, void>> subscribeToSymbol(String symbol);
  
  /// Subscribe to multiple symbols
  Future<Either<String, void>> subscribeToSymbols(List<String> symbols);
  
  /// Unsubscribe from a symbol
  Future<Either<String, void>> unsubscribeFromSymbol(String symbol);
  
  /// Check if currently listening
  bool get isListening;
  
  /// Get currently subscribed symbols
  Set<String> get subscribedSymbols;
  
  /// Dispose resources
  void dispose();
}