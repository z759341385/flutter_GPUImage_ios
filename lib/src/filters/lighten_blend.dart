import 'dart:typed_data';

import 'package:flutter_gpuimage/src/converter/uint8_list_converter.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lighten_blend.g.dart';

@JsonSerializable()
class LightenBlend  extends Object implements BaseFilter {

  @Uint8ListConverter()
  Uint8List blendImage;

  ///[blendImage]
  LightenBlend({
    required  this.blendImage});
  factory LightenBlend.fromJson(Map<String, dynamic> srcJson) => _$LightenBlendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LightenBlendToJson(this);


}