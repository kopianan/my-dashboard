// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketSummary {

 int get totalSymbols; double get averageChange; int get gainers; int get losers; int get unchanged;
/// Create a copy of MarketSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketSummaryCopyWith<MarketSummary> get copyWith => _$MarketSummaryCopyWithImpl<MarketSummary>(this as MarketSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketSummary&&(identical(other.totalSymbols, totalSymbols) || other.totalSymbols == totalSymbols)&&(identical(other.averageChange, averageChange) || other.averageChange == averageChange)&&(identical(other.gainers, gainers) || other.gainers == gainers)&&(identical(other.losers, losers) || other.losers == losers)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged));
}


@override
int get hashCode => Object.hash(runtimeType,totalSymbols,averageChange,gainers,losers,unchanged);

@override
String toString() {
  return 'MarketSummary(totalSymbols: $totalSymbols, averageChange: $averageChange, gainers: $gainers, losers: $losers, unchanged: $unchanged)';
}


}

/// @nodoc
abstract mixin class $MarketSummaryCopyWith<$Res>  {
  factory $MarketSummaryCopyWith(MarketSummary value, $Res Function(MarketSummary) _then) = _$MarketSummaryCopyWithImpl;
@useResult
$Res call({
 int totalSymbols, double averageChange, int gainers, int losers, int unchanged
});




}
/// @nodoc
class _$MarketSummaryCopyWithImpl<$Res>
    implements $MarketSummaryCopyWith<$Res> {
  _$MarketSummaryCopyWithImpl(this._self, this._then);

  final MarketSummary _self;
  final $Res Function(MarketSummary) _then;

/// Create a copy of MarketSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSymbols = null,Object? averageChange = null,Object? gainers = null,Object? losers = null,Object? unchanged = null,}) {
  return _then(_self.copyWith(
totalSymbols: null == totalSymbols ? _self.totalSymbols : totalSymbols // ignore: cast_nullable_to_non_nullable
as int,averageChange: null == averageChange ? _self.averageChange : averageChange // ignore: cast_nullable_to_non_nullable
as double,gainers: null == gainers ? _self.gainers : gainers // ignore: cast_nullable_to_non_nullable
as int,losers: null == losers ? _self.losers : losers // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketSummary].
extension MarketSummaryPatterns on MarketSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketSummary value)  $default,){
final _that = this;
switch (_that) {
case _MarketSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MarketSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSymbols,  double averageChange,  int gainers,  int losers,  int unchanged)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketSummary() when $default != null:
return $default(_that.totalSymbols,_that.averageChange,_that.gainers,_that.losers,_that.unchanged);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSymbols,  double averageChange,  int gainers,  int losers,  int unchanged)  $default,) {final _that = this;
switch (_that) {
case _MarketSummary():
return $default(_that.totalSymbols,_that.averageChange,_that.gainers,_that.losers,_that.unchanged);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSymbols,  double averageChange,  int gainers,  int losers,  int unchanged)?  $default,) {final _that = this;
switch (_that) {
case _MarketSummary() when $default != null:
return $default(_that.totalSymbols,_that.averageChange,_that.gainers,_that.losers,_that.unchanged);case _:
  return null;

}
}

}

/// @nodoc


class _MarketSummary implements MarketSummary {
  const _MarketSummary({required this.totalSymbols, required this.averageChange, required this.gainers, required this.losers, required this.unchanged});
  

@override final  int totalSymbols;
@override final  double averageChange;
@override final  int gainers;
@override final  int losers;
@override final  int unchanged;

/// Create a copy of MarketSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketSummaryCopyWith<_MarketSummary> get copyWith => __$MarketSummaryCopyWithImpl<_MarketSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketSummary&&(identical(other.totalSymbols, totalSymbols) || other.totalSymbols == totalSymbols)&&(identical(other.averageChange, averageChange) || other.averageChange == averageChange)&&(identical(other.gainers, gainers) || other.gainers == gainers)&&(identical(other.losers, losers) || other.losers == losers)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged));
}


@override
int get hashCode => Object.hash(runtimeType,totalSymbols,averageChange,gainers,losers,unchanged);

@override
String toString() {
  return 'MarketSummary(totalSymbols: $totalSymbols, averageChange: $averageChange, gainers: $gainers, losers: $losers, unchanged: $unchanged)';
}


}

/// @nodoc
abstract mixin class _$MarketSummaryCopyWith<$Res> implements $MarketSummaryCopyWith<$Res> {
  factory _$MarketSummaryCopyWith(_MarketSummary value, $Res Function(_MarketSummary) _then) = __$MarketSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalSymbols, double averageChange, int gainers, int losers, int unchanged
});




}
/// @nodoc
class __$MarketSummaryCopyWithImpl<$Res>
    implements _$MarketSummaryCopyWith<$Res> {
  __$MarketSummaryCopyWithImpl(this._self, this._then);

  final _MarketSummary _self;
  final $Res Function(_MarketSummary) _then;

/// Create a copy of MarketSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSymbols = null,Object? averageChange = null,Object? gainers = null,Object? losers = null,Object? unchanged = null,}) {
  return _then(_MarketSummary(
totalSymbols: null == totalSymbols ? _self.totalSymbols : totalSymbols // ignore: cast_nullable_to_non_nullable
as int,averageChange: null == averageChange ? _self.averageChange : averageChange // ignore: cast_nullable_to_non_nullable
as double,gainers: null == gainers ? _self.gainers : gainers // ignore: cast_nullable_to_non_nullable
as int,losers: null == losers ? _self.losers : losers // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
