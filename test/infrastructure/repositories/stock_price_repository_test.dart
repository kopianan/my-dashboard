import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/stock_price/stock_price_model.dart';
import 'package:dynamic_dashboard/infrastructure/repositories/stock_price_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStockPriceWebSocketDataSource extends Mock implements StockPriceWebSocketDataSource {}

void main() {
  late StockPriceRepositoryImpl repository;
  late MockStockPriceWebSocketDataSource mockDataSource;
  late StreamController<StockPriceResponseModel> stockPriceStreamController;
  late StreamController<WebSocketConnectionState> connectionStateStreamController;

  setUp(() {
    mockDataSource = MockStockPriceWebSocketDataSource();
    stockPriceStreamController = StreamController<StockPriceResponseModel>.broadcast();
    connectionStateStreamController = StreamController<WebSocketConnectionState>.broadcast();
    
    // Setup mock streams
    when(() => mockDataSource.stockPriceStream)
        .thenAnswer((_) => stockPriceStreamController.stream);
    when(() => mockDataSource.connectionStateStream)
        .thenAnswer((_) => connectionStateStreamController.stream);
    when(() => mockDataSource.subscribedSymbols).thenReturn(<String>{});
    when(() => mockDataSource.isConnected).thenReturn(false);
    when(() => mockDataSource.isPaused).thenReturn(false);
    
    repository = StockPriceRepositoryImpl(mockDataSource);
  });

  tearDown(() {
    stockPriceStreamController.close();
    connectionStateStreamController.close();
    repository.dispose();
  });

  group('StockPriceRepository', () {
    test('should provide stock price stream', () async {
      // act & assert
      expect(repository.stockPriceStream, isA<Stream<Either<String, StockPriceResponse>>>());
    });

    test('should provide connection state stream', () async {
      // act & assert  
      expect(repository.connectionStateStream, isA<Stream<WebSocketConnectionState>>());
    });

    test('should have initial state not listening', () async {
      // assert
      expect(repository.isListening, isFalse);
      expect(repository.subscribedSymbols, isEmpty);
    });

    test('should start listening and connect to WebSocket', () async {
      // arrange
      when(() => mockDataSource.connect()).thenAnswer((_) async {});

      // act
      final result = await repository.startListening();

      // assert
      expect(result, const Right(null));
      verify(() => mockDataSource.connect());
    });

    test('should handle connection errors when starting to listen', () async {
      // arrange
      when(() => mockDataSource.connect()).thenThrow(Exception('Connection failed'));

      // act
      final result = await repository.startListening();

      // assert
      expect(result, const Left('Failed to start listening: Exception: Connection failed'));
      verify(() => mockDataSource.connect());
    });

    test('should stop listening when currently listening', () async {
      // arrange
      when(() => mockDataSource.connect()).thenAnswer((_) async {});
      when(() => mockDataSource.disconnect()).thenAnswer((_) async {});
      
      // Start listening first
      await repository.startListening();

      // act
      final result = await repository.stopListening();

      // assert
      expect(result, const Right(null));
      verify(() => mockDataSource.disconnect());
    });

    test('should return Right when stop listening while not listening', () async {
      // act
      final result = await repository.stopListening();

      // assert
      expect(result, const Right(null));
      // disconnect should not be called since not listening
      verifyNever(() => mockDataSource.disconnect());
    });

    test('should emit stock price data when data source provides updates', () async {
      // arrange
      final tStockPriceResponse = StockPriceResponseModel(
        data: [
          StockTradeModel(
            p: 50000,
            s: 'BTCUSDT',
            t: DateTime.now().millisecondsSinceEpoch,
            v: 1.5,
          ),
        ],
        type: 'trade',
      );

      final receivedData = <Either<String, StockPriceResponse>>[];
      
      // act
      repository.stockPriceStream.listen(receivedData.add);

      stockPriceStreamController.add(tStockPriceResponse);
      await Future.delayed(const Duration(milliseconds: 100));

      // assert
      expect(receivedData.length, 1);
      expect(receivedData.first, isA<Right<String, StockPriceResponse>>());
    });

    test('should emit error when data source stream has error', () async {
      // arrange
      final receivedData = <Either<String, StockPriceResponse>>[];
      
      // act
      repository.stockPriceStream.listen(receivedData.add);

      stockPriceStreamController.addError('Stream error');
      await Future.delayed(const Duration(milliseconds: 100));

      // assert
      expect(receivedData.length, 1);
      expect(receivedData.first, const Left('Stock price stream error: Stream error'));
    });

    test('should dispose properly', () async {
      // arrange
      when(() => mockDataSource.dispose()).thenReturn(null);

      // act
      repository.dispose();

      // assert
      verify(() => mockDataSource.dispose());
    });
  });
}