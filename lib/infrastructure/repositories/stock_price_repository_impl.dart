import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/domain/repositories/stock_price_repository.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: StockPriceRepository)
class StockPriceRepositoryImpl implements StockPriceRepository {

  StockPriceRepositoryImpl(this._webSocketDataSource) {
    _initializeStreams();
  }
  final StockPriceWebSocketDataSource _webSocketDataSource;
  
  // Stream controllers for converting raw streams to Either streams
  final StreamController<Either<String, StockPriceResponse>> _stockPriceController = 
      StreamController<Either<String, StockPriceResponse>>.broadcast();
  
  StreamSubscription? _dataSourceSubscription;
  bool _isListening = false;
  final Set<String> _subscribedSymbols = <String>{};

  @override
  Stream<Either<String, StockPriceResponse>> get stockPriceStream => 
      _stockPriceController.stream;

  @override
  Stream<WebSocketConnectionState> get connectionStateStream => 
      _webSocketDataSource.connectionStateStream;

  @override
  bool get isListening => _isListening;

  @override
  Set<String> get subscribedSymbols => Set.from(_subscribedSymbols);

  void _initializeStreams() {
    // Listen to data source and convert to Either pattern
    _dataSourceSubscription = _webSocketDataSource.stockPriceStream.listen(
      (stockPriceResponse) {
        try {
          final domainResponse = stockPriceResponse.toDomain();
          _stockPriceController.add(Right(domainResponse));
          
          // developer.log(
          //   'Stock price update: ${domainResponse.data.length} trades',
          //   name: 'StockPriceRepo',
          // );
        } catch (e) {
          developer.log('Failed to convert stock price data: $e', name: 'StockPriceRepo');
          _stockPriceController.add(Left('Failed to process stock price data: $e'));
        }
      },
      onError: (error) {
        developer.log('Stock price stream error: $error', name: 'StockPriceRepo');
        _stockPriceController.add(Left('Stock price stream error: $error'));
      },
    );
  }

  @override
  Future<Either<String, void>> startListening() async {
    if (_isListening) {
      return const Right(null);
    }

    try {
      developer.log('Starting stock price listening', name: 'StockPriceRepo');
      
      await _webSocketDataSource.connect();
      _isListening = true;
      
      developer.log('Stock price listening started successfully', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to start stock price listening: $e', name: 'StockPriceRepo');
      return Left('Failed to start listening: $e');
    }
  }

  @override
  Future<Either<String, void>> stopListening() async {
    if (!_isListening) {
      return const Right(null);
    }

    try {
      developer.log('Stopping stock price listening', name: 'StockPriceRepo');
      
      await _webSocketDataSource.disconnect();
      _isListening = false;
      _subscribedSymbols.clear();
      
      developer.log('Stock price listening stopped successfully', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to stop stock price listening: $e', name: 'StockPriceRepo');
      return Left('Failed to stop listening: $e');
    }
  }

  @override
  Future<Either<String, void>> subscribeToSymbol(String symbol) async {
    if (!_webSocketDataSource.isConnected) {
      return const Left('WebSocket not connected. Please start listening first.');
    }

    if (_subscribedSymbols.contains(symbol)) {
      developer.log('Already subscribed to $symbol', name: 'StockPriceRepo');
      return const Right(null);
    }

    try {
      await _webSocketDataSource.subscribeToSymbol(symbol);
      _subscribedSymbols.add(symbol);
      
      developer.log('Successfully subscribed to $symbol', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to subscribe to $symbol: $e', name: 'StockPriceRepo');
      return Left('Failed to subscribe to $symbol: $e');
    }
  }

  @override
  Future<Either<String, void>> subscribeToSymbols(List<String> symbols) async {
    if (!_webSocketDataSource.isConnected) {
      return const Left('WebSocket not connected. Please start listening first.');
    }

    try {
      for (final symbol in symbols) {
        if (!_subscribedSymbols.contains(symbol)) {
          await _webSocketDataSource.subscribeToSymbol(symbol);
          _subscribedSymbols.add(symbol);
        }
      }
      
      developer.log('Successfully subscribed to ${symbols.length} symbols', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to subscribe to symbols: $e', name: 'StockPriceRepo');
      return Left('Failed to subscribe to symbols: $e');
    }
  }

  @override
  Future<Either<String, void>> unsubscribeFromSymbol(String symbol) async {
    if (!_webSocketDataSource.isConnected) {
      return const Left('WebSocket not connected.');
    }

    if (!_subscribedSymbols.contains(symbol)) {
      developer.log('Not subscribed to $symbol', name: 'StockPriceRepo');
      return const Right(null);
    }

    try {
      await _webSocketDataSource.unsubscribeFromSymbol(symbol);
      _subscribedSymbols.remove(symbol);
      
      developer.log('Successfully unsubscribed from $symbol', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to unsubscribe from $symbol: $e', name: 'StockPriceRepo');
      return Left('Failed to unsubscribe from $symbol: $e');
    }
  }

  @override
  Future<Either<String, void>> pauseListening() async {
    if (!_isListening) {
      return const Left('Not currently listening');
    }

    try {
      developer.log('Pausing stock price listening', name: 'StockPriceRepo');
      
      await _webSocketDataSource.pause();
      
      developer.log('Stock price listening paused successfully', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to pause stock price listening: $e', name: 'StockPriceRepo');
      return Left('Failed to pause listening: $e');
    }
  }

  @override
  Future<Either<String, void>> resumeListening() async {
    if (!_isListening) {
      return const Left('Not currently listening');
    }

    try {
      developer.log('Resuming stock price listening', name: 'StockPriceRepo');
      
      await _webSocketDataSource.resume();
      
      developer.log('Stock price listening resumed successfully', name: 'StockPriceRepo');
      return const Right(null);
      
    } catch (e) {
      developer.log('Failed to resume stock price listening: $e', name: 'StockPriceRepo');
      return Left('Failed to resume listening: $e');
    }
  }

  @override
  void dispose() {
    developer.log('Disposing stock price repository', name: 'StockPriceRepo');
    
    _dataSourceSubscription?.cancel();
    _stockPriceController.close();
    _webSocketDataSource.dispose();
    _subscribedSymbols.clear();
    _isListening = false;
  }
}