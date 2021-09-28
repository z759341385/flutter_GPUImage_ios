// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlights_and_shadows.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighlightsAndShadows _$HighlightsAndShadowsFromJson(Map<String, dynamic> json) {
  return HighlightsAndShadows(
    shadows: (json['shadows'] as num)?.toDouble(),
    highlights: (json['highlights'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HighlightsAndShadowsToJson(
        HighlightsAndShadows instance) =>
    <String, dynamic>{
      'shadows': instance.shadows,
      'highlights': instance.highlights,
    };
