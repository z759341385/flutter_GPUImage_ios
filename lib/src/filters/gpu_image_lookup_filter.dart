import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';
import 'package:flutter_gpuimage/src/converter/uint8_list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gpu_image_lookup_filter.g.dart';


@JsonSerializable()
class GPUImageLookupFilter extends Object implements BaseFilter {

  @Uint8ListConverter()
  Uint8List filterImage;

  GPUImageLookupFilter({ @required this.filterImage,});

  factory GPUImageLookupFilter.fromJson(Map<String, dynamic> srcJson) => _$GPUImageLookupFilterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GPUImageLookupFilterToJson(this);

}


