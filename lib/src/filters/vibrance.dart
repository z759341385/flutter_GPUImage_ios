import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vibrance.g.dart';

@JsonSerializable()
class Vibrance  extends Object implements BaseFilter {
  double value;

  ///[vibrance] 自然饱和度  The vibrance adjustment to apply, using 0.0 as the default, and a suggested min/max of around -1.2 and 1.2, respectively.
  Vibrance({
    required this.value});
  factory Vibrance.fromJson(Map<String, dynamic> srcJson) => _$VibranceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VibranceToJson(this);


}