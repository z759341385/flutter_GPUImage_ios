import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gaussianBlur.g.dart';

@JsonSerializable()
class GaussianBlur  extends Object implements BaseFilter {
  double blurRadiusInPixels;

  ///[blurRadiusInPixels] 高斯模糊  blurRadiusInPixels: A radius in pixels to use for the blur, with a default of 2.0. This adjusts the sigma variable in the Gaussian distribution function.
  GaussianBlur({
    required this.blurRadiusInPixels});
  factory GaussianBlur.fromJson(Map<String, dynamic> srcJson) => _$GaussianBlurFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GaussianBlurToJson(this);


}