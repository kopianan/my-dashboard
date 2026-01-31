// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockPriceResponse {

 List<StockTrade> get data; String get type;
/// Create a copy of StockPriceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockPriceResponseCopyWith<StockPriceResponse> get copyWith => _$StockPriceResponseCopyWithImpl<StockPriceResponse>(this as StockPriceResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockPriceResponse&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),type);

@override
String toString() {
  return 'StockPriceResponse(data: $data, type: $type)';
}


}

/// @nodoc
abstract mixin class $StockPriceResponseCopyWith<$Res>  {
  factory $StockPriceResponseCopyWith(StockPriceResponse value, $Res Function(StockPriceResponse) _then) = _$StockPriceResponseCopyWithImpl;
@useResult
$Res call({
 List<StockTrade> data, String type
});




}
/// @nodoc
class _$StockPriceResponseCopyWithImpl<$Res>
    implements $StockPriceResponseCopyWith<$Res> {
  _$StockPriceResponseCopyWithImpl(this._self, this._then);

  final StockPriceResponse _self;
  final $Res Function(StockPriceResponse) _then;

/// Create a copy of StockPriceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? type = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<StockTrade>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StockPriceResponse].
extension StockPriceResponsePatterns on StockPriceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockPriceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockPriceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockPriceResponse value)  $default,){
final _that = this;
switch (_that) {
case _StockPriceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockPriceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StockPriceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StockTrade> data,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockPriceResponse() when $default != null:
return $default(_that.data,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StockTrade> data,  String type)  $default,) {final _that = this;
switch (_that) {
case _StockPriceResponse():
return $default(_that.data,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StockTrade> data,  String type)?  $default,) {final _that = this;
switch (_that) {
case _StockPriceResponse() when $default != null:
return $default(_that.data,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _StockPriceResponse implements StockPriceResponse {
  const _StockPriceResponse({required final  List<StockTrade> data, required this.type}): _data = data;
  

 final  List<StockTrade> _data;
@override List<StockTrade> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  String type;

/// Create a copy of StockPriceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockPriceResponseCopyWith<_StockPriceResponse> get copyWith => __$StockPriceResponseCopyWithImpl<_StockPriceResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockPriceResponse&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),type);

@override
String toString() {
  return 'StockPriceResponse(data: $data, type: $type)';
}


}

/// @nodoc
abstract mixin class _$StockPriceResponseCopyWith<$Res> implements $StockPriceResponseCopyWith<$Res> {
  factory _$StockPriceResponseCopyWith(_StockPriceResponse value, $Res Function(_StockPriceResponse) _then) = __$StockPriceResponseCopyWithImpl;
@override @useResult
$Res call({
 List<StockTrade> data, String type
});




}
/// @nodoc
class __$StockPriceResponseCopyWithImpl<$Res>
    implements _$StockPriceResponseCopyWith<$Res> {
  __$StockPriceResponseCopyWithImpl(this._self, this._then);

  final _StockPriceResponse _self;
  final $Res Function(_StockPriceResponse) _then;

/// Create a copy of StockPriceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? type = null,}) {
  return _then(_StockPriceResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<StockTrade>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$StockTrade {

 String? get c; double get p;// price
 String get s;// symbol
 int get t;// timestamp
 double get v;
/// Create a copy of StockTrade
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockTradeCopyWith<StockTrade> get copyWith => _$StockTradeCopyWithImpl<StockTrade>(this as StockTrade, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockTrade&&(identical(other.c, c) || other.c == c)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s)&&(identical(other.t, t) || other.t == t)&&(identical(other.v, v) || other.v == v));
}


@override
int get hashCode => Object.hash(runtimeType,c,p,s,t,v);

@override
String toString() {
  return 'StockTrade(c: $c, p: $p, s: $s, t: $t, v: $v)';
}


}

/// @nodoc
abstract mixin class $StockTradeCopyWith<$Res>  {
  factory $StockTradeCopyWith(StockTrade value, $Res Function(StockTrade) _then) = _$StockTradeCopyWithImpl;
@useResult
$Res call({
 String? c, double p, String s, int t, double v
});




}
/// @nodoc
class _$StockTradeCopyWithImpl<$Res>
    implements $StockTradeCopyWith<$Res> {
  _$StockTradeCopyWithImpl(this._self, this._then);

  final StockTrade _self;
  final $Res Function(StockTrade) _then;

/// Create a copy of StockTrade
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? c = freezed,Object? p = null,Object? s = null,Object? t = null,Object? v = null,}) {
  return _then(_self.copyWith(
c: freezed == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as String?,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as double,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as String,t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as int,v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StockTrade].
extension StockTradePatterns on StockTrade {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockTrade value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockTrade() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockTrade value)  $default,){
final _that = this;
switch (_that) {
case _StockTrade():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockTrade value)?  $default,){
final _that = this;
switch (_that) {
case _StockTrade() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? c,  double p,  String s,  int t,  double v)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockTrade() when $default != null:
return $default(_that.c,_that.p,_that.s,_that.t,_that.v);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? c,  double p,  String s,  int t,  double v)  $default,) {final _that = this;
switch (_that) {
case _StockTrade():
return $default(_that.c,_that.p,_that.s,_that.t,_that.v);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? c,  double p,  String s,  int t,  double v)?  $default,) {final _that = this;
switch (_that) {
case _StockTrade() when $default != null:
return $default(_that.c,_that.p,_that.s,_that.t,_that.v);case _:
  return null;

}
}

}

/// @nodoc


class _StockTrade extends StockTrade {
  const _StockTrade({this.c, required this.p, required this.s, required this.t, required this.v}): super._();
  

@override final  String? c;
@override final  double p;
// price
@override final  String s;
// symbol
@override final  int t;
// timestamp
@override final  double v;

/// Create a copy of StockTrade
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockTradeCopyWith<_StockTrade> get copyWith => __$StockTradeCopyWithImpl<_StockTrade>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockTrade&&(identical(other.c, c) || other.c == c)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s)&&(identical(other.t, t) || other.t == t)&&(identical(other.v, v) || other.v == v));
}


@override
int get hashCode => Object.hash(runtimeType,c,p,s,t,v);

@override
String toString() {
  return 'StockTrade(c: $c, p: $p, s: $s, t: $t, v: $v)';
}


}

/// @nodoc
abstract mixin class _$StockTradeCopyWith<$Res> implements $StockTradeCopyWith<$Res> {
  factory _$StockTradeCopyWith(_StockTrade value, $Res Function(_StockTrade) _then) = __$StockTradeCopyWithImpl;
@override @useResult
$Res call({
 String? c, double p, String s, int t, double v
});




}
/// @nodoc
class __$StockTradeCopyWithImpl<$Res>
    implements _$StockTradeCopyWith<$Res> {
  __$StockTradeCopyWithImpl(this._self, this._then);

  final _StockTrade _self;
  final $Res Function(_StockTrade) _then;

/// Create a copy of StockTrade
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? c = freezed,Object? p = null,Object? s = null,Object? t = null,Object? v = null,}) {
  return _then(_StockTrade(
c: freezed == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as String?,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as double,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as String,t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as int,v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
