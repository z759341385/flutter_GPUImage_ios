// import 'package:flutter/foundation.dart';
// import 'package:flutter_gpuimage/src/filters/base_filter.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'highights_and_shadows.g.dart';
//
// @JsonSerializable()
// class HighlightsAndShadows  extends Object implements BaseFilter {
//
//   double shadowTintColor;
//   double highlightTintColor;
//   double shadowTintIntensity;
//   double highlightTintIntensity;
//
//   /// [shadowTintColor] Shadow tint RGB color (GPUVector4). Default: {1.0f, 0.0f, 0.0f, 1.0f} (red).
//   /// [highlightTintColor] Highlight tint RGB color (GPUVector4). Default: {0.0f, 0.0f, 1.0f, 1.0f} (blue).
//   /// [shadowTintIntensity] Shadow tint intensity, from 0.0 to 1.0. Default: 0.0
//   /// [highlightTintIntensity] Highlight tint intensity, from 0.0 to 1.0, with 0.0 as the default.
//   ///
//   HighlightsAndShadows({this.shadowTintColor ={1.0f, 0.0f, 0.0f, 1.0f},});
//   factory HighlightsAndShadows.fromJson(Map<String, dynamic> srcJson) => _$HighlightsAndShadowsFromJson(srcJson);
//
//   Map<String, dynamic> toJson() => _$HighlightsAndShadowsToJson(this);
//
//
// }