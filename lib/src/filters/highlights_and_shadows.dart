import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'highlights_and_shadows.g.dart';

@JsonSerializable()
class HighlightsAndShadows  extends Object implements BaseFilter {

  double shadows;
  double highlights;

  /// [shadows] Increase to lighten shadows, from 0.0 to 1.0, with 0.0 as the default.
  /// [highlights] Decrease to darken highlights, from 1.0 to 0.0, with 1.0 as the default.

  HighlightsAndShadows({this.shadows =0.0,this.highlights = 1.0});
  factory HighlightsAndShadows.fromJson(Map<String, dynamic> srcJson) => _$HighlightsAndShadowsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HighlightsAndShadowsToJson(this);


}