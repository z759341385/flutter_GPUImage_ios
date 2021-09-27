// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rgb_adjustment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RGBAdjustment _$RGBAdjustmentFromJson(Map<String, dynamic> json) {
  return RGBAdjustment(
    red: (json['red'] as num)?.toDouble(),
    green: (json['green'] as num)?.toDouble(),
    blue: (json['blue'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RGBAdjustmentToJson(RGBAdjustment instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
    };
