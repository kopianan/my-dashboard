import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/domain/repositories/stock_price_repository.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/providers/stock_price_data_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'stock_price_cubit.freezed.dart';
part 'stock_price_state.dart';

@injectable
class StockPriceCubit extends Cubit<StockPriceState> {
  StockPriceCubit(this._repository, this._dataProvider)
    : super(const StockPriceState.initial());
  final StockPriceRepository _repository;
  final StockPriceDataProvider _dataProvider;

  StreamSubscription? _priceStreamSubscription;
  StreamSubscription? _connectionStreamSubscription;

  /// Start listening to real-time stock price updates
  Future<void> startListening() async {
    if (state is _Connected || state is _Connecting) {
      developer.log('Already listening or connecting', name: 'StockPriceCubit');
      return;
    }

    emit(const StockPriceState.connecting());

    final result = await _repository.startListening();

    result.fold(
      (error) {
        developer.log(
          'Failed to start listening: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: error,
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
      (_) {
        developer.log(
          'Started listening successfully',
          name: 'StockPriceCubit',
        );
        _subscribeToStreams();
        _emitConnectedState();
      },
    );
  }

  /// Stop listening to stock price updates
  Future<void> stopListening() async {
    developer.log('Stopping stock price listening', name: 'StockPriceCubit');

    await _unsubscribeFromStreams();

    final result = await _repository.stopListening();
    result.fold(
      (error) {
        developer.log(
          'Error stopping listening: $error',
          name: 'StockPriceCubit',
        );
        emit(StockPriceState.error(message: error));
      },
      (_) {
        _dataProvider.clearData();
        emit(const StockPriceState.initial());
        developer.log(
          'Stopped listening successfully',
          name: 'StockPriceCubit',
        );
      },
    );
  }

  /// Subscribe to a specific symbol
  Future<void> subscribeToSymbol(String symbol) async {
    final result = await _repository.subscribeToSymbol(symbol);
    result.fold(
      (error) {
        developer.log(
          'Failed to subscribe to $symbol: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: 'Failed to subscribe to $symbol: $error',
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
      (_) {
        developer.log(
          'Successfully subscribed to $symbol',
          name: 'StockPriceCubit',
        );
        _emitConnectedState();
      },
    );
  }

  /// Subscribe to multiple symbols
  Future<void> subscribeToSymbols(List<String> symbols) async {
    final result = await _repository.subscribeToSymbols(symbols);
    result.fold(
      (error) {
        developer.log(
          'Failed to subscribe to symbols: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: 'Failed to subscribe to symbols: $error',
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
      (_) {
        developer.log(
          'Successfully subscribed to ${symbols.length} symbols',
          name: 'StockPriceCubit',
        );
        _emitConnectedState();
      },
    );
  }

  /// Unsubscribe from a symbol
  Future<void> unsubscribeFromSymbol(String symbol) async {
    final result = await _repository.unsubscribeFromSymbol(symbol);
    result.fold(
      (error) {
        developer.log(
          'Failed to unsubscribe from $symbol: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: 'Failed to unsubscribe from $symbol: $error',
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
      (_) {
        _dataProvider.clearSymbolData(symbol);
        developer.log(
          'Successfully unsubscribed from $symbol',
          name: 'StockPriceCubit',
        );
        _emitConnectedState();
      },
    );
  }

  /// Get latest price for a specific symbol
  StockTrade? getLatestPrice(String symbol) {
    return _dataProvider.getLatestPrice(symbol);
  }

  /// Get all latest prices
  Map<String, StockTrade> getAllLatestPrices() {
    return _dataProvider.getAllLatestPrices();
  }

  /// Get price change for a symbol
  double getPriceChange(String symbol) {
    return _dataProvider.getPriceChange(symbol);
  }

  /// Check if price is increasing
  bool isPriceIncreasing(String symbol) {
    return _dataProvider.isPriceIncreasing(symbol);
  }

  /// Get formatted price
  String getFormattedPrice(String symbol, {String currency = r'$'}) {
    return _dataProvider.getFormattedPrice(symbol, currency: currency);
  }

  /// Get market summary
  MarketSummary getMarketSummary() {
    return _dataProvider.getMarketSummary();
  }

  /// Get sorted symbols by priority
  List<String> getSortedSymbols() {
    return _dataProvider.getSortedSymbols();
  }

  /// Get top performing symbols
  List<String> getTopPerformingSymbols({int limit = 5}) {
    return _dataProvider.getTopPerformingSymbols(limit: limit);
  }

  void _subscribeToStreams() {
    // Listen to price updates
    _priceStreamSubscription = _repository.stockPriceStream.listen(
      (either) {
        if (isClosed) return; // Prevent emission after close
        either.fold(
          (error) {
            developer.log(
              'Price stream error: $error',
              name: 'StockPriceCubit',
            );
            emit(
              StockPriceState.error(
                message: error,
                latestPrices: _dataProvider.getAllLatestPrices(),
              ),
            );
          },
          (stockPriceResponse) {
            _dataProvider.processStockPriceResponse(stockPriceResponse);
            _emitConnectedState();
          },
        );
      },
      onError: (error) {
        if (isClosed) return; // Prevent emission after close
        developer.log(
          'Price stream subscription error: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: 'Connection error: $error',
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
    );

    // Listen to connection state changes
    _connectionStreamSubscription = _repository.connectionStateStream.listen((
      connectionState,
    ) {
      if (isClosed) return; // Prevent emission after close
      developer.log(
        'Connection state changed: $connectionState',
        name: 'StockPriceCubit',
      );

      switch (connectionState) {
        case WebSocketConnectionState.connecting:
          if (state is! _Connecting) {
            emit(const StockPriceState.connecting());
          }
        case WebSocketConnectionState.connected:
          _emitConnectedState();
        case WebSocketConnectionState.disconnected:
        case WebSocketConnectionState.error:
          emit(
            StockPriceState.error(
              message: 'Connection ${connectionState.name}',
              latestPrices: _dataProvider.getAllLatestPrices(),
            ),
          );
        case WebSocketConnectionState.reconnecting:
          // Keep current state but could show reconnecting indicator
          break;
        case WebSocketConnectionState.paused:
          // Keep current state - paused state maintains data but stops processing
          break;
      }
    });
  }

  Future<void> _unsubscribeFromStreams() async {
    await _priceStreamSubscription?.cancel();
    await _connectionStreamSubscription?.cancel();
    _priceStreamSubscription = null;
    _connectionStreamSubscription = null;
  }

  void _emitConnectedState() {
    if (isClosed) return; // Prevent emission after close
    // Get current connection state from repository (if available)
    emit(
      StockPriceState.connected(
        latestPrices: _dataProvider.getAllLatestPrices(),
        connectionState: WebSocketConnectionState.connected,
        subscribedSymbols: _repository.subscribedSymbols,
      ),
    );
  }

  /// Pause stock price listening (for app lifecycle management)
  Future<void> pauseListening() async {
    final result = await _repository.pauseListening();
    result.fold(
      (error) {
        developer.log(
          'Failed to pause listening: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: 'Failed to pause listening: $error',
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
      (_) {
        developer.log(
          'Successfully paused stock price listening',
          name: 'StockPriceCubit',
        );
        // Keep current state data but indicate paused status if needed
        emit(
          StockPriceState.connected(
            latestPrices: _dataProvider.getAllLatestPrices(),
            connectionState:
                WebSocketConnectionState.connected, // Could add paused state
            subscribedSymbols: _repository.subscribedSymbols,
          ),
        );
      },
    );
  }

  /// Resume stock price listening (for app lifecycle management)
  Future<void> resumeListening() async {
    final result = await _repository.resumeListening();
    result.fold(
      (error) {
        developer.log(
          'Failed to resume listening: $error',
          name: 'StockPriceCubit',
        );
        emit(
          StockPriceState.error(
            message: 'Failed to resume listening: $error',
            latestPrices: _dataProvider.getAllLatestPrices(),
          ),
        );
      },
      (_) {
        developer.log(
          'Successfully resumed stock price listening',
          name: 'StockPriceCubit',
        );
        _emitConnectedState();
      },
    );
  }

  @override
  Future<void> close() async {
    developer.log('Closing StockPriceCubit', name: 'StockPriceCubit');

    // Unsubscribe from streams first
    await _unsubscribeFromStreams();

    // Stop listening but don't emit states since we're closing
    final result = await _repository.stopListening();
    result.fold(
      (error) {
        developer.log(
          'Error stopping listening during close: $error',
          name: 'StockPriceCubit',
        );
        // Don't emit error state during close
      },
      (_) {
        _dataProvider.clearData();
        developer.log(
          'Stopped listening successfully during close',
          name: 'StockPriceCubit',
        );
        // Don't emit initial state during close
      },
    );

    _repository.dispose();

    return super.close();
  }
}
