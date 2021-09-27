import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rgb_adjustment.g.dart';

@JsonSerializable()
class RGBAdjustment extends Object implements BaseFilter {
  double red;
  double green;
  double blue;

  ///[RGBAdjustment] rgb通道
  /// [red] Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.
  /// [green] Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.
  /// [blue] Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.

  RGBAdjustment({this.red = 1.0, this.green=1.0,this.blue = 1.0});
  factory RGBAdjustment.fromJson(Map<String, dynamic> srcJson) => _$RGBAdjustmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RGBAdjustmentToJson(this);
}
