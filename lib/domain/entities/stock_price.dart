import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_price.freezed.dart';

@freezed
abstract class StockPriceResponse with _$StockPriceResponse {
  const factory StockPriceResponse({
    required List<StockTrade> data,
    required String type,
  }) = _StockPriceResponse;
}

@freezed
abstract class StockTrade with _$StockTrade {
  const factory StockTrade({
    String? c,
    required double p, // price
    required String s, // symbol
    required int t, // timestamp
    required double v, // volume
  }) = _StockTrade;

  const StockTrade._();

  /// Get DateTime from timestamp
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(t);
  
  /// Get formatted symbol (remove exchange prefix)
  String get formattedSymbol {
    if (s.contains(':')) {
      return s.split(':').last;
    }
    return s;
  }
  
  /// Get exchange name
  String get exchange {
    if (s.contains(':')) {
      return s.split(':').first;
    }
    return 'Unknown';
  }
}