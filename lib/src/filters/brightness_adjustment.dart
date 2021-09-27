import 'package:flutter/material.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'brightness_adjustment.g.dart';

@JsonSerializable()
class BrightnessAdjustment  extends Object implements BaseFilter {
  double value;

  ///[brightness] 亮度 The adjusted brightness (-1.0 - 1.0, with 0.0 as the default)
  BrightnessAdjustment({
    @required  this.value});
  factory BrightnessAdjustment.fromJson(Map<String, dynamic> srcJson) => _$BrightnessAdjustmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrightnessAdjustmentToJson(this);


}