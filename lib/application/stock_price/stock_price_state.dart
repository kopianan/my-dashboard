part of 'stock_price_cubit.dart';

@freezed
class StockPriceState with _$StockPriceState {
  const factory StockPriceState.initial() = _Initial;
  const factory StockPriceState.connecting() = _Connecting;
  const factory StockPriceState.connected({
    required Map<String, StockTrade> latestPrices,
    required WebSocketConnectionState connectionState,
    required Set<String> subscribedSymbols,
  }) = _Connected;
  const factory StockPriceState.error({
    required String message,
    Map<String, StockTrade>? latestPrices,
  }) = _Error;
}