// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsResponseModel {

 String get status; int get totalResults; List<NewsArticleModel> get articles;
/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsResponseModelCopyWith<NewsResponseModel> get copyWith => _$NewsResponseModelCopyWithImpl<NewsResponseModel>(this as NewsResponseModel, _$identity);

  /// Serializes this NewsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&const DeepCollectionEquality().equals(other.articles, articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,totalResults,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'NewsResponseModel(status: $status, totalResults: $totalResults, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $NewsResponseModelCopyWith<$Res>  {
  factory $NewsResponseModelCopyWith(NewsResponseModel value, $Res Function(NewsResponseModel) _then) = _$NewsResponseModelCopyWithImpl;
@useResult
$Res call({
 String status, int totalResults, List<NewsArticleModel> articles
});




}
/// @nodoc
class _$NewsResponseModelCopyWithImpl<$Res>
    implements $NewsResponseModelCopyWith<$Res> {
  _$NewsResponseModelCopyWithImpl(this._self, this._then);

  final NewsResponseModel _self;
  final $Res Function(NewsResponseModel) _then;

/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? totalResults = null,Object? articles = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<NewsArticleModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsResponseModel].
extension NewsResponseModelPatterns on NewsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _NewsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  int totalResults,  List<NewsArticleModel> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
return $default(_that.status,_that.totalResults,_that.articles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  int totalResults,  List<NewsArticleModel> articles)  $default,) {final _that = this;
switch (_that) {
case _NewsResponseModel():
return $default(_that.status,_that.totalResults,_that.articles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  int totalResults,  List<NewsArticleModel> articles)?  $default,) {final _that = this;
switch (_that) {
case _NewsResponseModel() when $default != null:
return $default(_that.status,_that.totalResults,_that.articles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsResponseModel extends NewsResponseModel {
  const _NewsResponseModel({required this.status, required this.totalResults, required final  List<NewsArticleModel> articles}): _articles = articles,super._();
  factory _NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);

@override final  String status;
@override final  int totalResults;
 final  List<NewsArticleModel> _articles;
@override List<NewsArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsResponseModelCopyWith<_NewsResponseModel> get copyWith => __$NewsResponseModelCopyWithImpl<_NewsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&const DeepCollectionEquality().equals(other._articles, _articles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,totalResults,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'NewsResponseModel(status: $status, totalResults: $totalResults, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$NewsResponseModelCopyWith<$Res> implements $NewsResponseModelCopyWith<$Res> {
  factory _$NewsResponseModelCopyWith(_NewsResponseModel value, $Res Function(_NewsResponseModel) _then) = __$NewsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String status, int totalResults, List<NewsArticleModel> articles
});




}
/// @nodoc
class __$NewsResponseModelCopyWithImpl<$Res>
    implements _$NewsResponseModelCopyWith<$Res> {
  __$NewsResponseModelCopyWithImpl(this._self, this._then);

  final _NewsResponseModel _self;
  final $Res Function(_NewsResponseModel) _then;

/// Create a copy of NewsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? totalResults = null,Object? articles = null,}) {
  return _then(_NewsResponseModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<NewsArticleModel>,
  ));
}


}


/// @nodoc
mixin _$NewsArticleModel {

 NewsSourceModel get source; String get title; String get url; String get publishedAt; String? get author; String? get description; String? get urlToImage; String? get content;
/// Create a copy of NewsArticleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsArticleModelCopyWith<NewsArticleModel> get copyWith => _$NewsArticleModelCopyWithImpl<NewsArticleModel>(this as NewsArticleModel, _$identity);

  /// Serializes this NewsArticleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsArticleModel&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,title,url,publishedAt,author,description,urlToImage,content);

@override
String toString() {
  return 'NewsArticleModel(source: $source, title: $title, url: $url, publishedAt: $publishedAt, author: $author, description: $description, urlToImage: $urlToImage, content: $content)';
}


}

/// @nodoc
abstract mixin class $NewsArticleModelCopyWith<$Res>  {
  factory $NewsArticleModelCopyWith(NewsArticleModel value, $Res Function(NewsArticleModel) _then) = _$NewsArticleModelCopyWithImpl;
@useResult
$Res call({
 NewsSourceModel source, String title, String url, String publishedAt, String? author, String? description, String? urlToImage, String? content
});


$NewsSourceModelCopyWith<$Res> get source;

}
/// @nodoc
class _$NewsArticleModelCopyWithImpl<$Res>
    implements $NewsArticleModelCopyWith<$Res> {
  _$NewsArticleModelCopyWithImpl(this._self, this._then);

  final NewsArticleModel _self;
  final $Res Function(NewsArticleModel) _then;

/// Create a copy of NewsArticleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? title = null,Object? url = null,Object? publishedAt = null,Object? author = freezed,Object? description = freezed,Object? urlToImage = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NewsSourceModel,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NewsArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsSourceModelCopyWith<$Res> get source {
  
  return $NewsSourceModelCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewsArticleModel].
extension NewsArticleModelPatterns on NewsArticleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsArticleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsArticleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsArticleModel value)  $default,){
final _that = this;
switch (_that) {
case _NewsArticleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsArticleModel value)?  $default,){
final _that = this;
switch (_that) {
case _NewsArticleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NewsSourceModel source,  String title,  String url,  String publishedAt,  String? author,  String? description,  String? urlToImage,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsArticleModel() when $default != null:
return $default(_that.source,_that.title,_that.url,_that.publishedAt,_that.author,_that.description,_that.urlToImage,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NewsSourceModel source,  String title,  String url,  String publishedAt,  String? author,  String? description,  String? urlToImage,  String? content)  $default,) {final _that = this;
switch (_that) {
case _NewsArticleModel():
return $default(_that.source,_that.title,_that.url,_that.publishedAt,_that.author,_that.description,_that.urlToImage,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NewsSourceModel source,  String title,  String url,  String publishedAt,  String? author,  String? description,  String? urlToImage,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _NewsArticleModel() when $default != null:
return $default(_that.source,_that.title,_that.url,_that.publishedAt,_that.author,_that.description,_that.urlToImage,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsArticleModel extends NewsArticleModel {
  const _NewsArticleModel({required this.source, required this.title, required this.url, required this.publishedAt, this.author, this.description, this.urlToImage, this.content}): super._();
  factory _NewsArticleModel.fromJson(Map<String, dynamic> json) => _$NewsArticleModelFromJson(json);

@override final  NewsSourceModel source;
@override final  String title;
@override final  String url;
@override final  String publishedAt;
@override final  String? author;
@override final  String? description;
@override final  String? urlToImage;
@override final  String? content;

/// Create a copy of NewsArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsArticleModelCopyWith<_NewsArticleModel> get copyWith => __$NewsArticleModelCopyWithImpl<_NewsArticleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsArticleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsArticleModel&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,title,url,publishedAt,author,description,urlToImage,content);

@override
String toString() {
  return 'NewsArticleModel(source: $source, title: $title, url: $url, publishedAt: $publishedAt, author: $author, description: $description, urlToImage: $urlToImage, content: $content)';
}


}

/// @nodoc
abstract mixin class _$NewsArticleModelCopyWith<$Res> implements $NewsArticleModelCopyWith<$Res> {
  factory _$NewsArticleModelCopyWith(_NewsArticleModel value, $Res Function(_NewsArticleModel) _then) = __$NewsArticleModelCopyWithImpl;
@override @useResult
$Res call({
 NewsSourceModel source, String title, String url, String publishedAt, String? author, String? description, String? urlToImage, String? content
});


@override $NewsSourceModelCopyWith<$Res> get source;

}
/// @nodoc
class __$NewsArticleModelCopyWithImpl<$Res>
    implements _$NewsArticleModelCopyWith<$Res> {
  __$NewsArticleModelCopyWithImpl(this._self, this._then);

  final _NewsArticleModel _self;
  final $Res Function(_NewsArticleModel) _then;

/// Create a copy of NewsArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? title = null,Object? url = null,Object? publishedAt = null,Object? author = freezed,Object? description = freezed,Object? urlToImage = freezed,Object? content = freezed,}) {
  return _then(_NewsArticleModel(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NewsSourceModel,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NewsArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsSourceModelCopyWith<$Res> get source {
  
  return $NewsSourceModelCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
mixin _$NewsSourceModel {

 String get name; String? get id;
/// Create a copy of NewsSourceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSourceModelCopyWith<NewsSourceModel> get copyWith => _$NewsSourceModelCopyWithImpl<NewsSourceModel>(this as NewsSourceModel, _$identity);

  /// Serializes this NewsSourceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSourceModel&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'NewsSourceModel(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class $NewsSourceModelCopyWith<$Res>  {
  factory $NewsSourceModelCopyWith(NewsSourceModel value, $Res Function(NewsSourceModel) _then) = _$NewsSourceModelCopyWithImpl;
@useResult
$Res call({
 String name, String? id
});




}
/// @nodoc
class _$NewsSourceModelCopyWithImpl<$Res>
    implements $NewsSourceModelCopyWith<$Res> {
  _$NewsSourceModelCopyWithImpl(this._self, this._then);

  final NewsSourceModel _self;
  final $Res Function(NewsSourceModel) _then;

/// Create a copy of NewsSourceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsSourceModel].
extension NewsSourceModelPatterns on NewsSourceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsSourceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsSourceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsSourceModel value)  $default,){
final _that = this;
switch (_that) {
case _NewsSourceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsSourceModel value)?  $default,){
final _that = this;
switch (_that) {
case _NewsSourceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsSourceModel() when $default != null:
return $default(_that.name,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? id)  $default,) {final _that = this;
switch (_that) {
case _NewsSourceModel():
return $default(_that.name,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _NewsSourceModel() when $default != null:
return $default(_that.name,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsSourceModel extends NewsSourceModel {
  const _NewsSourceModel({required this.name, this.id}): super._();
  factory _NewsSourceModel.fromJson(Map<String, dynamic> json) => _$NewsSourceModelFromJson(json);

@override final  String name;
@override final  String? id;

/// Create a copy of NewsSourceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsSourceModelCopyWith<_NewsSourceModel> get copyWith => __$NewsSourceModelCopyWithImpl<_NewsSourceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsSourceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsSourceModel&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'NewsSourceModel(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class _$NewsSourceModelCopyWith<$Res> implements $NewsSourceModelCopyWith<$Res> {
  factory _$NewsSourceModelCopyWith(_NewsSourceModel value, $Res Function(_NewsSourceModel) _then) = __$NewsSourceModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String? id
});




}
/// @nodoc
class __$NewsSourceModelCopyWithImpl<$Res>
    implements _$NewsSourceModelCopyWith<$Res> {
  __$NewsSourceModelCopyWithImpl(this._self, this._then);

  final _NewsSourceModel _self;
  final $Res Function(_NewsSourceModel) _then;

/// Create a copy of NewsSourceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = freezed,}) {
  return _then(_NewsSourceModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
