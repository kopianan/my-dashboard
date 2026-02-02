// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockPriceResponseModel _$StockPriceResponseModelFromJson(
  Map<String, dynamic> json,
) => _StockPriceResponseModel(
  data: (json['data'] as List<dynamic>)
      .map((e) => StockTradeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  type: json['type'] as String,
);

Map<String, dynamic> _$StockPriceResponseModelToJson(
  _StockPriceResponseModel instance,
) => <String, dynamic>{'data': instance.data, 'type': instance.type};

_StockTradeModel _$StockTradeModelFromJson(Map<String, dynamic> json) =>
    _StockTradeModel(
      p: (json['p'] as num).toDouble(),
      s: json['s'] as String,
      t: (json['t'] as num).toInt(),
      v: (json['v'] as num).toDouble(),
      c: json['c'] as String?,
    );

Map<String, dynamic> _$StockTradeModelToJson(_StockTradeModel instance) =>
    <String, dynamic>{
      'p': instance.p,
      's': instance.s,
      't': instance.t,
      'v': instance.v,
      'c': instance.c,
    };
