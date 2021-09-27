import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'haze.g.dart';

@JsonSerializable()
class Haze extends Object implements BaseFilter {
  double distance;
  double slope;

  ///[haze] 薄雾增删
  ///[distance] Strength of the color applied. Default 0. Values between -.3 and .3 are best.
  ///[slope] Amount of color change. Default 0. Values between -.3 and .3 are best.
  Haze({this.distance = 0.0, this.slope=0.0});
  factory Haze.fromJson(Map<String, dynamic> srcJson) => _$HazeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HazeToJson(this);
}
