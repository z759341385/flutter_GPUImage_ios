// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haze.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Haze _$HazeFromJson(Map<String, dynamic> json) => Haze(
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      slope: (json['slope'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$HazeToJson(Haze instance) => <String, dynamic>{
      'distance': instance.distance,
      'slope': instance.slope,
    };
