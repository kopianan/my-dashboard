// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_price_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockPriceResponseModel {

 List<StockTradeModel> get data; String get type;
/// Create a copy of StockPriceResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockPriceResponseModelCopyWith<StockPriceResponseModel> get copyWith => _$StockPriceResponseModelCopyWithImpl<StockPriceResponseModel>(this as StockPriceResponseModel, _$identity);

  /// Serializes this StockPriceResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockPriceResponseModel&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),type);

@override
String toString() {
  return 'StockPriceResponseModel(data: $data, type: $type)';
}


}

/// @nodoc
abstract mixin class $StockPriceResponseModelCopyWith<$Res>  {
  factory $StockPriceResponseModelCopyWith(StockPriceResponseModel value, $Res Function(StockPriceResponseModel) _then) = _$StockPriceResponseModelCopyWithImpl;
@useResult
$Res call({
 List<StockTradeModel> data, String type
});




}
/// @nodoc
class _$StockPriceResponseModelCopyWithImpl<$Res>
    implements $StockPriceResponseModelCopyWith<$Res> {
  _$StockPriceResponseModelCopyWithImpl(this._self, this._then);

  final StockPriceResponseModel _self;
  final $Res Function(StockPriceResponseModel) _then;

/// Create a copy of StockPriceResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? type = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<StockTradeModel>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StockPriceResponseModel].
extension StockPriceResponseModelPatterns on StockPriceResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockPriceResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockPriceResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockPriceResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _StockPriceResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockPriceResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _StockPriceResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StockTradeModel> data,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockPriceResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StockTradeModel> data,  String type)  $default,) {final _that = this;
switch (_that) {
case _StockPriceResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StockTradeModel> data,  String type)?  $default,) {final _that = this;
switch (_that) {
case _StockPriceResponseModel() when $default != null:
return $default(_that.data,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockPriceResponseModel extends StockPriceResponseModel {
  const _StockPriceResponseModel({required final  List<StockTradeModel> data, required this.type}): _data = data,super._();
  factory _StockPriceResponseModel.fromJson(Map<String, dynamic> json) => _$StockPriceResponseModelFromJson(json);

 final  List<StockTradeModel> _data;
@override List<StockTradeModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  String type;

/// Create a copy of StockPriceResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockPriceResponseModelCopyWith<_StockPriceResponseModel> get copyWith => __$StockPriceResponseModelCopyWithImpl<_StockPriceResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockPriceResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockPriceResponseModel&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),type);

@override
String toString() {
  return 'StockPriceResponseModel(data: $data, type: $type)';
}


}

/// @nodoc
abstract mixin class _$StockPriceResponseModelCopyWith<$Res> implements $StockPriceResponseModelCopyWith<$Res> {
  factory _$StockPriceResponseModelCopyWith(_StockPriceResponseModel value, $Res Function(_StockPriceResponseModel) _then) = __$StockPriceResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<StockTradeModel> data, String type
});




}
/// @nodoc
class __$StockPriceResponseModelCopyWithImpl<$Res>
    implements _$StockPriceResponseModelCopyWith<$Res> {
  __$StockPriceResponseModelCopyWithImpl(this._self, this._then);

  final _StockPriceResponseModel _self;
  final $Res Function(_StockPriceResponseModel) _then;

/// Create a copy of StockPriceResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? type = null,}) {
  return _then(_StockPriceResponseModel(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<StockTradeModel>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StockTradeModel {

 String? get c; double get p;// price
 String get s;// symbol
 int get t;// timestamp
 double get v;
/// Create a copy of StockTradeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockTradeModelCopyWith<StockTradeModel> get copyWith => _$StockTradeModelCopyWithImpl<StockTradeModel>(this as StockTradeModel, _$identity);

  /// Serializes this StockTradeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockTradeModel&&(identical(other.c, c) || other.c == c)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s)&&(identical(other.t, t) || other.t == t)&&(identical(other.v, v) || other.v == v));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,c,p,s,t,v);

@override
String toString() {
  return 'StockTradeModel(c: $c, p: $p, s: $s, t: $t, v: $v)';
}


}

/// @nodoc
abstract mixin class $StockTradeModelCopyWith<$Res>  {
  factory $StockTradeModelCopyWith(StockTradeModel value, $Res Function(StockTradeModel) _then) = _$StockTradeModelCopyWithImpl;
@useResult
$Res call({
 String? c, double p, String s, int t, double v
});




}
/// @nodoc
class _$StockTradeModelCopyWithImpl<$Res>
    implements $StockTradeModelCopyWith<$Res> {
  _$StockTradeModelCopyWithImpl(this._self, this._then);

  final StockTradeModel _self;
  final $Res Function(StockTradeModel) _then;

/// Create a copy of StockTradeModel
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


/// Adds pattern-matching-related methods to [StockTradeModel].
extension StockTradeModelPatterns on StockTradeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockTradeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockTradeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockTradeModel value)  $default,){
final _that = this;
switch (_that) {
case _StockTradeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockTradeModel value)?  $default,){
final _that = this;
switch (_that) {
case _StockTradeModel() when $default != null:
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
case _StockTradeModel() when $default != null:
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
case _StockTradeModel():
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
case _StockTradeModel() when $default != null:
return $default(_that.c,_that.p,_that.s,_that.t,_that.v);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockTradeModel extends StockTradeModel {
  const _StockTradeModel({this.c, required this.p, required this.s, required this.t, required this.v}): super._();
  factory _StockTradeModel.fromJson(Map<String, dynamic> json) => _$StockTradeModelFromJson(json);

@override final  String? c;
@override final  double p;
// price
@override final  String s;
// symbol
@override final  int t;
// timestamp
@override final  double v;

/// Create a copy of StockTradeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockTradeModelCopyWith<_StockTradeModel> get copyWith => __$StockTradeModelCopyWithImpl<_StockTradeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockTradeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockTradeModel&&(identical(other.c, c) || other.c == c)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s)&&(identical(other.t, t) || other.t == t)&&(identical(other.v, v) || other.v == v));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,c,p,s,t,v);

@override
String toString() {
  return 'StockTradeModel(c: $c, p: $p, s: $s, t: $t, v: $v)';
}


}

/// @nodoc
abstract mixin class _$StockTradeModelCopyWith<$Res> implements $StockTradeModelCopyWith<$Res> {
  factory _$StockTradeModelCopyWith(_StockTradeModel value, $Res Function(_StockTradeModel) _then) = __$StockTradeModelCopyWithImpl;
@override @useResult
$Res call({
 String? c, double p, String s, int t, double v
});




}
/// @nodoc
class __$StockTradeModelCopyWithImpl<$Res>
    implements _$StockTradeModelCopyWith<$Res> {
  __$StockTradeModelCopyWithImpl(this._self, this._then);

  final _StockTradeModel _self;
  final $Res Function(_StockTradeModel) _then;

/// Create a copy of StockTradeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? c = freezed,Object? p = null,Object? s = null,Object? t = null,Object? v = null,}) {
  return _then(_StockTradeModel(
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
