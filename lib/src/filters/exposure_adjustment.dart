import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exposure_adjustment.g.dart';

@JsonSerializable()
class ExposureAdjustment  extends Object implements BaseFilter {
  double value;

  ///[exposure] 曝光 The adjusted exposure (-10.0 - 10.0, with 0.0 as the default)
  ExposureAdjustment({
    this.value});
  factory ExposureAdjustment.fromJson(Map<String, dynamic> srcJson) => _$ExposureAdjustmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExposureAdjustmentToJson(this);


}