import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_price_model.freezed.dart';
part 'stock_price_model.g.dart';

@freezed
abstract class StockPriceResponseModel with _$StockPriceResponseModel {
  const factory StockPriceResponseModel({
    required List<StockTradeModel> data,
    required String type,
  }) = _StockPriceResponseModel;

  factory StockPriceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StockPriceResponseModelFromJson(json);

  const StockPriceResponseModel._();

  StockPriceResponse toDomain() {
    return StockPriceResponse(
      data: data.map((trade) => trade.toDomain()).toList(),
      type: type,
    );
  }

  /// Get the latest trade data (last item in the array)
  StockTradeModel? get latestTrade {
    if (data.isEmpty) return null;
    return data.last;
  }
}

@freezed
abstract class StockTradeModel with _$StockTradeModel {
  const factory StockTradeModel({
    String? c,
    required double p, // price
    required String s, // symbol
    required int t, // timestamp
    required double v, // volume
  }) = _StockTradeModel;

  factory StockTradeModel.fromJson(Map<String, dynamic> json) =>
      _$StockTradeModelFromJson(json);

  const StockTradeModel._();

  StockTrade toDomain() {
    return StockTrade(c: c, p: p, s: s, t: t, v: v);
  }
}
