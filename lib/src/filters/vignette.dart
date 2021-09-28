import 'package:flutter/foundation.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vignette.g.dart';

@JsonSerializable()
class Vignette extends Object implements BaseFilter{
  double positionX;
  double positionY;
  double colorRed;
  double colorGreen;
  double colorBlue;
  double start;
  double end;

  /// [center] The center for the vignette in tex coords (CGPoint), with a default of 0.5, 0.5
  /// [color] The color to use for the vignette (GPUVector3), with a default of black
  /// [start] The normalized distance from the center where the vignette effect starts, with a default of 0.5
  /// [end] The normalized distance from the center where the vignette effect ends, with a default of 0.75
  Vignette({
      this.positionX = 0.5,
      this.positionY = 0.5,
      this.colorRed = 0,
      this.colorGreen = 0,
      this.colorBlue = 0,
      this.start  = 0.5,
      this.end = 0.75});

  factory Vignette.fromJson(Map<String, dynamic> srcJson) => _$VignetteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VignetteToJson(this);
}