// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpu_image_lookup_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GPUImageLookupFilter _$GPUImageLookupFilterFromJson(
        Map<String, dynamic> json) =>
    GPUImageLookupFilter(
      filterImage:
          const Uint8ListConverter().fromJson(json['filterImage'] as List<int>),
    );

Map<String, dynamic> _$GPUImageLookupFilterToJson(
        GPUImageLookupFilter instance) =>
    <String, dynamic>{
      'filterImage': const Uint8ListConverter().toJson(instance.filterImage),
    };
