import 'dart:async';

import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource_impl.dart';
import 'package:dynamic_dashboard/infrastructure/models/stock_price/stock_price_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helper.dart';

class MockAppConfig extends Mock implements AppConfig {}

void main() {
  late StockPriceWebSocketDataSourceImpl datasource;
  late MockWebSocketChannel mockWebSocketChannel;
  late MockWebSocketSink mockWebSocketSink;
  late StreamController<dynamic> streamController;
  late MockAppConfig mockAppConfig;

  setUp(() {
    mockWebSocketChannel = MockWebSocketChannel();
    mockWebSocketSink = MockWebSocketSink();
    streamController = StreamController<dynamic>();
    mockAppConfig = MockAppConfig();
    
    when(() => mockAppConfig.finnhubWsUrlWithToken).thenReturn('wss://ws.finnhub.io?token=test_token');
    
    datasource = StockPriceWebSocketDataSourceImpl(mockAppConfig);

    // Setup WebSocket mocks
    when(() => mockWebSocketChannel.sink).thenReturn(mockWebSocketSink);
    when(
      () => mockWebSocketChannel.stream,
    ).thenAnswer((_) => streamController.stream);
  });

  tearDown(() {
    streamController.close();
    datasource.dispose();
  });

  group('StockPriceWebSocketDataSource', () {
    test('should have initial state as disconnected', () async {
      // assert
      expect(datasource.isConnected, isFalse);
      expect(datasource.isPaused, isFalse);
      expect(datasource.subscribedSymbols, isEmpty);
    });

    test('should handle dispose properly', () async {
      // act
      datasource.dispose();

      // assert - no exception should be thrown
      expect(datasource.isConnected, isFalse);
    });

    test('should have correct initial subscribed symbols', () async {
      // assert - initially empty until connected
      expect(datasource.subscribedSymbols, isEmpty);
    });

    test('should handle pause and resume state correctly', () async {
      // Test pause state (even when not connected)
      await datasource.pause();
      expect(datasource.isPaused, isFalse);
      
      // Test resume state
      await datasource.resume();
      expect(datasource.isPaused, isFalse);
    });
    
    test('should provide proper stream getters', () async {
      // assert - streams should be available
      expect(datasource.stockPriceStream, isA<Stream<StockPriceResponseModel>>());
      expect(datasource.connectionStateStream, isA<Stream<WebSocketConnectionState>>());
    });
  });
}
