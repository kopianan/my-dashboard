import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_summary.freezed.dart';

@freezed
abstract class MarketSummary with _$MarketSummary {
  const factory MarketSummary({
    required int totalSymbols,
    required double averageChange,
    required int gainers,
    required int losers,
    required int unchanged,
  }) = _MarketSummary;
}
