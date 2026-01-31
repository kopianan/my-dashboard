// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_price_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockPriceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockPriceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockPriceState()';
}


}

/// @nodoc
class $StockPriceStateCopyWith<$Res>  {
$StockPriceStateCopyWith(StockPriceState _, $Res Function(StockPriceState) __);
}


/// Adds pattern-matching-related methods to [StockPriceState].
extension StockPriceStatePatterns on StockPriceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Connecting value)?  connecting,TResult Function( _Connected value)?  connected,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Connecting() when connecting != null:
return connecting(_that);case _Connected() when connected != null:
return connected(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Connecting value)  connecting,required TResult Function( _Connected value)  connected,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Connecting():
return connecting(_that);case _Connected():
return connected(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Connecting value)?  connecting,TResult? Function( _Connected value)?  connected,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Connecting() when connecting != null:
return connecting(_that);case _Connected() when connected != null:
return connected(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  connecting,TResult Function( Map<String, StockTrade> latestPrices,  WebSocketConnectionState connectionState,  Set<String> subscribedSymbols)?  connected,TResult Function( String message,  Map<String, StockTrade>? latestPrices)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Connecting() when connecting != null:
return connecting();case _Connected() when connected != null:
return connected(_that.latestPrices,_that.connectionState,_that.subscribedSymbols);case _Error() when error != null:
return error(_that.message,_that.latestPrices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  connecting,required TResult Function( Map<String, StockTrade> latestPrices,  WebSocketConnectionState connectionState,  Set<String> subscribedSymbols)  connected,required TResult Function( String message,  Map<String, StockTrade>? latestPrices)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Connecting():
return connecting();case _Connected():
return connected(_that.latestPrices,_that.connectionState,_that.subscribedSymbols);case _Error():
return error(_that.message,_that.latestPrices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  connecting,TResult? Function( Map<String, StockTrade> latestPrices,  WebSocketConnectionState connectionState,  Set<String> subscribedSymbols)?  connected,TResult? Function( String message,  Map<String, StockTrade>? latestPrices)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Connecting() when connecting != null:
return connecting();case _Connected() when connected != null:
return connected(_that.latestPrices,_that.connectionState,_that.subscribedSymbols);case _Error() when error != null:
return error(_that.message,_that.latestPrices);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements StockPriceState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockPriceState.initial()';
}


}




/// @nodoc


class _Connecting implements StockPriceState {
  const _Connecting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connecting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockPriceState.connecting()';
}


}




/// @nodoc


class _Connected implements StockPriceState {
  const _Connected({required final  Map<String, StockTrade> latestPrices, required this.connectionState, required final  Set<String> subscribedSymbols}): _latestPrices = latestPrices,_subscribedSymbols = subscribedSymbols;
  

 final  Map<String, StockTrade> _latestPrices;
 Map<String, StockTrade> get latestPrices {
  if (_latestPrices is EqualUnmodifiableMapView) return _latestPrices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_latestPrices);
}

 final  WebSocketConnectionState connectionState;
 final  Set<String> _subscribedSymbols;
 Set<String> get subscribedSymbols {
  if (_subscribedSymbols is EqualUnmodifiableSetView) return _subscribedSymbols;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_subscribedSymbols);
}


/// Create a copy of StockPriceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectedCopyWith<_Connected> get copyWith => __$ConnectedCopyWithImpl<_Connected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connected&&const DeepCollectionEquality().equals(other._latestPrices, _latestPrices)&&(identical(other.connectionState, connectionState) || other.connectionState == connectionState)&&const DeepCollectionEquality().equals(other._subscribedSymbols, _subscribedSymbols));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_latestPrices),connectionState,const DeepCollectionEquality().hash(_subscribedSymbols));

@override
String toString() {
  return 'StockPriceState.connected(latestPrices: $latestPrices, connectionState: $connectionState, subscribedSymbols: $subscribedSymbols)';
}


}

/// @nodoc
abstract mixin class _$ConnectedCopyWith<$Res> implements $StockPriceStateCopyWith<$Res> {
  factory _$ConnectedCopyWith(_Connected value, $Res Function(_Connected) _then) = __$ConnectedCopyWithImpl;
@useResult
$Res call({
 Map<String, StockTrade> latestPrices, WebSocketConnectionState connectionState, Set<String> subscribedSymbols
});




}
/// @nodoc
class __$ConnectedCopyWithImpl<$Res>
    implements _$ConnectedCopyWith<$Res> {
  __$ConnectedCopyWithImpl(this._self, this._then);

  final _Connected _self;
  final $Res Function(_Connected) _then;

/// Create a copy of StockPriceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latestPrices = null,Object? connectionState = null,Object? subscribedSymbols = null,}) {
  return _then(_Connected(
latestPrices: null == latestPrices ? _self._latestPrices : latestPrices // ignore: cast_nullable_to_non_nullable
as Map<String, StockTrade>,connectionState: null == connectionState ? _self.connectionState : connectionState // ignore: cast_nullable_to_non_nullable
as WebSocketConnectionState,subscribedSymbols: null == subscribedSymbols ? _self._subscribedSymbols : subscribedSymbols // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

/// @nodoc


class _Error implements StockPriceState {
  const _Error({required this.message, final  Map<String, StockTrade>? latestPrices}): _latestPrices = latestPrices;
  

 final  String message;
 final  Map<String, StockTrade>? _latestPrices;
 Map<String, StockTrade>? get latestPrices {
  final value = _latestPrices;
  if (value == null) return null;
  if (_latestPrices is EqualUnmodifiableMapView) return _latestPrices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of StockPriceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._latestPrices, _latestPrices));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_latestPrices));

@override
String toString() {
  return 'StockPriceState.error(message: $message, latestPrices: $latestPrices)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $StockPriceStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, Map<String, StockTrade>? latestPrices
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of StockPriceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? latestPrices = freezed,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,latestPrices: freezed == latestPrices ? _self._latestPrices : latestPrices // ignore: cast_nullable_to_non_nullable
as Map<String, StockTrade>?,
  ));
}


}

// dart format on
