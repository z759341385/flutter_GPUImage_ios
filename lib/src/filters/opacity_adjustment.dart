import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'opacity_adjustment.g.dart';

@JsonSerializable()
class OpacityAdjustment extends Object implements BaseFilter {
  double opacity;

  ///[opacity] 透明度 The value to multiply the incoming alpha channel for each pixel by (0.0 - 1.0, with 1.0 as the default)

  OpacityAdjustment({this.opacity = 1.0,});
  factory OpacityAdjustment.fromJson(Map<String, dynamic> srcJson) => _$OpacityAdjustmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OpacityAdjustmentToJson(this);
}
