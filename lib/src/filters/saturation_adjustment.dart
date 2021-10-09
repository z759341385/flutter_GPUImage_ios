import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'saturation_adjustment.g.dart';

@JsonSerializable()
class SaturationAdjustment  extends Object implements BaseFilter {
  double value;

  ///[saturation] 饱和度  The degree of saturation or desaturation to apply to the image (0.0 - 2.0, with 1.0 as the default)
  SaturationAdjustment({
    required this.value});
  factory SaturationAdjustment.fromJson(Map<String, dynamic> srcJson) => _$SaturationAdjustmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SaturationAdjustmentToJson(this);


}