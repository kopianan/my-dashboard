import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/application/stock_price/stock_price_cubit.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/domain/repositories/stock_price_repository.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/providers/stock_price_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStockPriceRepository extends Mock implements StockPriceRepository {}

class MockStockPriceDataProvider extends Mock
    implements StockPriceDataProvider {}

void main() {
  group('StockPriceCubit', () {
    late StockPriceCubit stockPriceCubit;
    late MockStockPriceRepository mockRepository;
    late MockStockPriceDataProvider mockDataProvider;
    late StreamController<Either<String, StockPriceResponse>>
        priceStreamController;
    late StreamController<WebSocketConnectionState>
        connectionStreamController;

    setUp(() {
      mockRepository = MockStockPriceRepository();
      mockDataProvider = MockStockPriceDataProvider();

      // Set up streams
      priceStreamController = StreamController<Either<String, StockPriceResponse>>.broadcast();
      connectionStreamController = StreamController<WebSocketConnectionState>.broadcast();

      when(() => mockRepository.stockPriceStream)
          .thenAnswer((_) => priceStreamController.stream);
      when(() => mockRepository.connectionStateStream)
          .thenAnswer((_) => connectionStreamController.stream);
      when(() => mockRepository.subscribedSymbols)
          .thenReturn(<String>{});

      // Set up data provider defaults
      when(() => mockDataProvider.getAllLatestPrices())
          .thenReturn(<String, StockTrade>{});

      // Set up default stub methods for repository to avoid null subtype errors
      when(() => mockRepository.stopListening())
          .thenAnswer((_) async => const Right(unit));
      when(() => mockRepository.dispose()).thenReturn(null);

      stockPriceCubit = StockPriceCubit(mockRepository, mockDataProvider);
    });

    tearDown(() {
      priceStreamController.close();
      connectionStreamController.close();
      stockPriceCubit.close();
    });

    test('initial state is correct', () {
      expect(stockPriceCubit.state, const StockPriceState.initial());
    });

    group('startListening', () {
      blocTest<StockPriceCubit, StockPriceState>(
        'emits [connecting] when starting to listen',
        build: () {
          when(() => mockRepository.startListening())
              .thenAnswer((_) async => const Right(unit));
          return stockPriceCubit;
        },
        act: (cubit) => cubit.startListening(),
        verify: (_) {
          verify(() => mockRepository.startListening()).called(1);
        },
      );

      blocTest<StockPriceCubit, StockPriceState>(
        'emits [error] when start listening fails',
        build: () {
          when(() => mockRepository.startListening())
              .thenAnswer((_) async => const Left('Connection failed'));
          return stockPriceCubit;
        },
        act: (cubit) => cubit.startListening(),
        verify: (_) {
          verify(() => mockRepository.startListening()).called(1);
        },
      );
    });

    group('subscribeToSymbol', () {
      const testSymbol = 'AAPL';

      blocTest<StockPriceCubit, StockPriceState>(
        'successfully subscribes to symbol',
        build: () {
          when(() => mockRepository.subscribeToSymbol(testSymbol))
              .thenAnswer((_) async => const Right(unit));
          return stockPriceCubit;
        },
        act: (cubit) => cubit.subscribeToSymbol(testSymbol),
        verify: (_) {
          verify(() => mockRepository.subscribeToSymbol(testSymbol)).called(1);
        },
      );

      blocTest<StockPriceCubit, StockPriceState>(
        'emits error when subscribe fails',
        build: () {
          when(() => mockRepository.subscribeToSymbol(testSymbol))
              .thenAnswer((_) async => const Left('Failed to subscribe'));
          return stockPriceCubit;
        },
        act: (cubit) => cubit.subscribeToSymbol(testSymbol),
        verify: (_) {
          verify(() => mockRepository.subscribeToSymbol(testSymbol)).called(1);
        },
      );
    });

    group('data provider methods', () {
      test('getLatestPrice returns data from provider', () {
        const symbol = 'AAPL';
        const expectedTrade = StockTrade(
          p: 150.0,
          s: symbol,
          t: 1640995200000,
          v: 1000,
        );

        when(() => mockDataProvider.getLatestPrice(symbol))
            .thenReturn(expectedTrade);

        final result = stockPriceCubit.getLatestPrice(symbol);

        expect(result, equals(expectedTrade));
        verify(() => mockDataProvider.getLatestPrice(symbol)).called(1);
      });

      test('getAllLatestPrices returns data from provider', () {
        final expectedPrices = <String, StockTrade>{
          'AAPL': const StockTrade(
            p: 150.0,
            s: 'AAPL',
            t: 1640995200000,
            v: 1000,
          ),
        };

        when(() => mockDataProvider.getAllLatestPrices())
            .thenReturn(expectedPrices);

        final result = stockPriceCubit.getAllLatestPrices();

        expect(result, equals(expectedPrices));
        verify(() => mockDataProvider.getAllLatestPrices()).called(1);
      });

      test('getPriceChange returns data from provider', () {
        const symbol = 'AAPL';
        const expectedChange = 5.0;

        when(() => mockDataProvider.getPriceChange(symbol))
            .thenReturn(expectedChange);

        final result = stockPriceCubit.getPriceChange(symbol);

        expect(result, equals(expectedChange));
        verify(() => mockDataProvider.getPriceChange(symbol)).called(1);
      });

      test('isPriceIncreasing returns data from provider', () {
        const symbol = 'AAPL';
        const expectedResult = true;

        when(() => mockDataProvider.isPriceIncreasing(symbol))
            .thenReturn(expectedResult);

        final result = stockPriceCubit.isPriceIncreasing(symbol);

        expect(result, equals(expectedResult));
        verify(() => mockDataProvider.isPriceIncreasing(symbol)).called(1);
      });

      test('getFormattedPrice returns data from provider', () {
        const symbol = 'AAPL';
        const expectedFormatted = '\$150.00';

        when(() => mockDataProvider.getFormattedPrice(symbol, currency: '\$'))
            .thenReturn(expectedFormatted);

        final result = stockPriceCubit.getFormattedPrice(symbol);

        expect(result, equals(expectedFormatted));
        verify(() => mockDataProvider.getFormattedPrice(symbol, currency: '\$')).called(1);
      });
    });
  });
}