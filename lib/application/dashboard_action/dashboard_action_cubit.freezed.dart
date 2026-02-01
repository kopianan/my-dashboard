// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_action_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardActionState {

 StockPriceCubit get stockPriceCubit; WeatherCubit get weatherCubit; NewsCubit get newsCubit; String get cardOrderKey; List<String> get cardOrder;
/// Create a copy of DashboardActionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardActionStateCopyWith<DashboardActionState> get copyWith => _$DashboardActionStateCopyWithImpl<DashboardActionState>(this as DashboardActionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardActionState&&(identical(other.stockPriceCubit, stockPriceCubit) || other.stockPriceCubit == stockPriceCubit)&&(identical(other.weatherCubit, weatherCubit) || other.weatherCubit == weatherCubit)&&(identical(other.newsCubit, newsCubit) || other.newsCubit == newsCubit)&&(identical(other.cardOrderKey, cardOrderKey) || other.cardOrderKey == cardOrderKey)&&const DeepCollectionEquality().equals(other.cardOrder, cardOrder));
}


@override
int get hashCode => Object.hash(runtimeType,stockPriceCubit,weatherCubit,newsCubit,cardOrderKey,const DeepCollectionEquality().hash(cardOrder));

@override
String toString() {
  return 'DashboardActionState(stockPriceCubit: $stockPriceCubit, weatherCubit: $weatherCubit, newsCubit: $newsCubit, cardOrderKey: $cardOrderKey, cardOrder: $cardOrder)';
}


}

/// @nodoc
abstract mixin class $DashboardActionStateCopyWith<$Res>  {
  factory $DashboardActionStateCopyWith(DashboardActionState value, $Res Function(DashboardActionState) _then) = _$DashboardActionStateCopyWithImpl;
@useResult
$Res call({
 StockPriceCubit stockPriceCubit, WeatherCubit weatherCubit, NewsCubit newsCubit, String cardOrderKey, List<String> cardOrder
});




}
/// @nodoc
class _$DashboardActionStateCopyWithImpl<$Res>
    implements $DashboardActionStateCopyWith<$Res> {
  _$DashboardActionStateCopyWithImpl(this._self, this._then);

  final DashboardActionState _self;
  final $Res Function(DashboardActionState) _then;

/// Create a copy of DashboardActionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stockPriceCubit = null,Object? weatherCubit = null,Object? newsCubit = null,Object? cardOrderKey = null,Object? cardOrder = null,}) {
  return _then(_self.copyWith(
stockPriceCubit: null == stockPriceCubit ? _self.stockPriceCubit : stockPriceCubit // ignore: cast_nullable_to_non_nullable
as StockPriceCubit,weatherCubit: null == weatherCubit ? _self.weatherCubit : weatherCubit // ignore: cast_nullable_to_non_nullable
as WeatherCubit,newsCubit: null == newsCubit ? _self.newsCubit : newsCubit // ignore: cast_nullable_to_non_nullable
as NewsCubit,cardOrderKey: null == cardOrderKey ? _self.cardOrderKey : cardOrderKey // ignore: cast_nullable_to_non_nullable
as String,cardOrder: null == cardOrder ? _self.cardOrder : cardOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardActionState].
extension DashboardActionStatePatterns on DashboardActionState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardActionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardActionState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardActionState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardActionState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardActionState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardActionState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StockPriceCubit stockPriceCubit,  WeatherCubit weatherCubit,  NewsCubit newsCubit,  String cardOrderKey,  List<String> cardOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardActionState() when $default != null:
return $default(_that.stockPriceCubit,_that.weatherCubit,_that.newsCubit,_that.cardOrderKey,_that.cardOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StockPriceCubit stockPriceCubit,  WeatherCubit weatherCubit,  NewsCubit newsCubit,  String cardOrderKey,  List<String> cardOrder)  $default,) {final _that = this;
switch (_that) {
case _DashboardActionState():
return $default(_that.stockPriceCubit,_that.weatherCubit,_that.newsCubit,_that.cardOrderKey,_that.cardOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StockPriceCubit stockPriceCubit,  WeatherCubit weatherCubit,  NewsCubit newsCubit,  String cardOrderKey,  List<String> cardOrder)?  $default,) {final _that = this;
switch (_that) {
case _DashboardActionState() when $default != null:
return $default(_that.stockPriceCubit,_that.weatherCubit,_that.newsCubit,_that.cardOrderKey,_that.cardOrder);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardActionState extends DashboardActionState {
   _DashboardActionState({required this.stockPriceCubit, required this.weatherCubit, required this.newsCubit, this.cardOrderKey = 'dashboard_card_order', final  List<String> cardOrder = const ['weather', 'news', 'stock']}): _cardOrder = cardOrder,super._();
  

@override final  StockPriceCubit stockPriceCubit;
@override final  WeatherCubit weatherCubit;
@override final  NewsCubit newsCubit;
@override@JsonKey() final  String cardOrderKey;
 final  List<String> _cardOrder;
@override@JsonKey() List<String> get cardOrder {
  if (_cardOrder is EqualUnmodifiableListView) return _cardOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cardOrder);
}


/// Create a copy of DashboardActionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardActionStateCopyWith<_DashboardActionState> get copyWith => __$DashboardActionStateCopyWithImpl<_DashboardActionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardActionState&&(identical(other.stockPriceCubit, stockPriceCubit) || other.stockPriceCubit == stockPriceCubit)&&(identical(other.weatherCubit, weatherCubit) || other.weatherCubit == weatherCubit)&&(identical(other.newsCubit, newsCubit) || other.newsCubit == newsCubit)&&(identical(other.cardOrderKey, cardOrderKey) || other.cardOrderKey == cardOrderKey)&&const DeepCollectionEquality().equals(other._cardOrder, _cardOrder));
}


@override
int get hashCode => Object.hash(runtimeType,stockPriceCubit,weatherCubit,newsCubit,cardOrderKey,const DeepCollectionEquality().hash(_cardOrder));

@override
String toString() {
  return 'DashboardActionState(stockPriceCubit: $stockPriceCubit, weatherCubit: $weatherCubit, newsCubit: $newsCubit, cardOrderKey: $cardOrderKey, cardOrder: $cardOrder)';
}


}

/// @nodoc
abstract mixin class _$DashboardActionStateCopyWith<$Res> implements $DashboardActionStateCopyWith<$Res> {
  factory _$DashboardActionStateCopyWith(_DashboardActionState value, $Res Function(_DashboardActionState) _then) = __$DashboardActionStateCopyWithImpl;
@override @useResult
$Res call({
 StockPriceCubit stockPriceCubit, WeatherCubit weatherCubit, NewsCubit newsCubit, String cardOrderKey, List<String> cardOrder
});




}
/// @nodoc
class __$DashboardActionStateCopyWithImpl<$Res>
    implements _$DashboardActionStateCopyWith<$Res> {
  __$DashboardActionStateCopyWithImpl(this._self, this._then);

  final _DashboardActionState _self;
  final $Res Function(_DashboardActionState) _then;

/// Create a copy of DashboardActionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stockPriceCubit = null,Object? weatherCubit = null,Object? newsCubit = null,Object? cardOrderKey = null,Object? cardOrder = null,}) {
  return _then(_DashboardActionState(
stockPriceCubit: null == stockPriceCubit ? _self.stockPriceCubit : stockPriceCubit // ignore: cast_nullable_to_non_nullable
as StockPriceCubit,weatherCubit: null == weatherCubit ? _self.weatherCubit : weatherCubit // ignore: cast_nullable_to_non_nullable
as WeatherCubit,newsCubit: null == newsCubit ? _self.newsCubit : newsCubit // ignore: cast_nullable_to_non_nullable
as NewsCubit,cardOrderKey: null == cardOrderKey ? _self.cardOrderKey : cardOrderKey // ignore: cast_nullable_to_non_nullable
as String,cardOrder: null == cardOrder ? _self._cardOrder : cardOrder // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
