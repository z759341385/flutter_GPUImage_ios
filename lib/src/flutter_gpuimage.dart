import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gpuimage/src/filters/base_filter.dart';

class FlutterGpuimage {
  static const MethodChannel _channel = const MethodChannel('flutter_gpuimage');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Uint8List> progressImage(
      {@required Uint8List sourceImage,
      @required List<BaseFilter> filters}) async {
    List<Map<String, dynamic>> filtersJSON = [];
    filters.forEach((element) {
      filtersJSON.add(
          {'name': element.runtimeType.toString(), 'data': element.toJson()});
    });
    return await _channel.invokeMethod(
        'progressImage', {'sourceImage': sourceImage, 'filters': filtersJSON});
  }

  static Future test(int value)async{
    return await _channel.invokeMethod(
        'testMethod', {'value': value});
  }
}
