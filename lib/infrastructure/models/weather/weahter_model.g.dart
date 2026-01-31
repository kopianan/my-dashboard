// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weahter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) =>
    _WeatherModel(
      coord: CoordModel.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: MainModel.fromJson(json['main'] as Map<String, dynamic>),
      timezone: (json['timezone'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(_WeatherModel instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'main': instance.main,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
    };

_CoordModel _$CoordModelFromJson(Map<String, dynamic> json) => _CoordModel(
  lon: (json['lon'] as num).toDouble(),
  lat: (json['lat'] as num).toDouble(),
);

Map<String, dynamic> _$CoordModelToJson(_CoordModel instance) =>
    <String, dynamic>{'lon': instance.lon, 'lat': instance.lat};

_WeatherInfoModel _$WeatherInfoModelFromJson(Map<String, dynamic> json) =>
    _WeatherInfoModel(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherInfoModelToJson(_WeatherInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

_MainModel _$MainModelFromJson(Map<String, dynamic> json) => _MainModel(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  tempMin: (json['temp_min'] as num).toDouble(),
  tempMax: (json['temp_max'] as num).toDouble(),
  pressure: (json['pressure'] as num).toInt(),
  humidity: (json['humidity'] as num).toInt(),
  seaLevel: (json['sea_level'] as num).toInt(),
  grndLevel: (json['grnd_level'] as num).toInt(),
);

Map<String, dynamic> _$MainModelToJson(_MainModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };
