// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vignette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vignette _$VignetteFromJson(Map<String, dynamic> json) {
  return Vignette(
    positionX: (json['positionX'] as num)?.toDouble(),
    positionY: (json['positionY'] as num)?.toDouble(),
    colorRed: (json['colorRed'] as num)?.toDouble(),
    colorGreen: (json['colorGreen'] as num)?.toDouble(),
    colorBlue: (json['colorBlue'] as num)?.toDouble(),
    start: (json['start'] as num)?.toDouble(),
    end: (json['end'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$VignetteToJson(Vignette instance) => <String, dynamic>{
      'positionX': instance.positionX,
      'positionY': instance.positionY,
      'colorRed': instance.colorRed,
      'colorGreen': instance.colorGreen,
      'colorBlue': instance.colorBlue,
      'start': instance.start,
      'end': instance.end,
    };
