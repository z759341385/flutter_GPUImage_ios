// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlights_and_shadows.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighlightsAndShadows _$HighlightsAndShadowsFromJson(
        Map<String, dynamic> json) =>
    HighlightsAndShadows(
      shadows: (json['shadows'] as num?)?.toDouble() ?? 0.0,
      highlights: (json['highlights'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$HighlightsAndShadowsToJson(
        HighlightsAndShadows instance) =>
    <String, dynamic>{
      'shadows': instance.shadows,
      'highlights': instance.highlights,
    };
