import 'dart:typed_data';

import 'package:flutter_gpuimage/src/converter/uint8_list_converter.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subtract_blend.g.dart';

@JsonSerializable()
class SubtractBlend  extends Object implements BaseFilter {

  @Uint8ListConverter()
  Uint8List blendImage;

  ///[blendImage]
  SubtractBlend({
    required  this.blendImage});
  factory SubtractBlend.fromJson(Map<String, dynamic> srcJson) => _$SubtractBlendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SubtractBlendToJson(this);


}