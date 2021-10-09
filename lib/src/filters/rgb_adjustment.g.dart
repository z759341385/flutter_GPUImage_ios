// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rgb_adjustment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RGBAdjustment _$RGBAdjustmentFromJson(Map<String, dynamic> json) =>
    RGBAdjustment(
      red: (json['red'] as num?)?.toDouble() ?? 1.0,
      green: (json['green'] as num?)?.toDouble() ?? 1.0,
      blue: (json['blue'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$RGBAdjustmentToJson(RGBAdjustment instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
    };
