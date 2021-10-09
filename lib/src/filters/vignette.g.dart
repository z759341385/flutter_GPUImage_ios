// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vignette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vignette _$VignetteFromJson(Map<String, dynamic> json) => Vignette(
      positionX: (json['positionX'] as num?)?.toDouble() ?? 0.5,
      positionY: (json['positionY'] as num?)?.toDouble() ?? 0.5,
      colorRed: (json['colorRed'] as num?)?.toDouble() ?? 0,
      colorGreen: (json['colorGreen'] as num?)?.toDouble() ?? 0,
      colorBlue: (json['colorBlue'] as num?)?.toDouble() ?? 0,
      start: (json['start'] as num?)?.toDouble() ?? 0.5,
      end: (json['end'] as num?)?.toDouble() ?? 0.75,
    );

Map<String, dynamic> _$VignetteToJson(Vignette instance) => <String, dynamic>{
      'positionX': instance.positionX,
      'positionY': instance.positionY,
      'colorRed': instance.colorRed,
      'colorGreen': instance.colorGreen,
      'colorBlue': instance.colorBlue,
      'start': instance.start,
      'end': instance.end,
    };
