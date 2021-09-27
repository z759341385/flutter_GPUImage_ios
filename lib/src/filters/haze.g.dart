// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haze.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Haze _$HazeFromJson(Map<String, dynamic> json) {
  return Haze(
    distance: (json['distance'] as num)?.toDouble(),
    slope: (json['slope'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HazeToJson(Haze instance) => <String, dynamic>{
      'distance': instance.distance,
      'slope': instance.slope,
    };
