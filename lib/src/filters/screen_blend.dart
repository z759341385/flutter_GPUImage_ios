import 'dart:typed_data';

import 'package:flutter_gpuimage/src/converter/uint8_list_converter.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'screen_blend.g.dart';

@JsonSerializable()
class ScreenBlend  extends Object implements BaseFilter {

  @Uint8ListConverter()
  Uint8List blendImage;

  ///[blendImage]
  ScreenBlend({
    required  this.blendImage});
  factory ScreenBlend.fromJson(Map<String, dynamic> srcJson) => _$ScreenBlendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ScreenBlendToJson(this);


}