import 'package:flutter/material.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contrast_adjustment.g.dart';

@JsonSerializable()
class ContrastAdjustment  extends Object implements BaseFilter {
  double value;

  ///[contrast] 对比度  The adjusted contrast (0.0 - 4.0, with 1.0 as the default)
  ContrastAdjustment({
   @required this.value});
  factory ContrastAdjustment.fromJson(Map<String, dynamic> srcJson) => _$ContrastAdjustmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContrastAdjustmentToJson(this);


}