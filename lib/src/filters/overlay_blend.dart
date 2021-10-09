import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gpuimage/src/converter/uint8_list_converter.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'overlay_blend.g.dart';

@JsonSerializable()
class OverlayBlend  extends Object implements BaseFilter {

  @Uint8ListConverter()
  Uint8List blendImage;

  ///[blendImage]
  OverlayBlend({
    required  this.blendImage});
  factory OverlayBlend.fromJson(Map<String, dynamic> srcJson) => _$OverlayBlendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OverlayBlendToJson(this);


}