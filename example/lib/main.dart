import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gpuimage/flutter_gpuimage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Uint8List _image;
  late int testValue;
  Map params = {
    'status': 0,
    'isRecommend': 0,
    'name': 'gold200',
    'intro': '我是XM1921的简介',
    'imgPath': 'assets/images/film/gold200.png',
    'params': {
      'brightnessAdj': {'brightness': 0.1},
      'contrastAdj': {'contrast': 1.0},
      'rgbAdj': {'red': 0.5, 'green': 0.5, 'blue': 0.5},
      'exposureAdj': {'exposure': 0.1},
      'gaussianBlur': {'blurRadiusInPixels': 2.0},
      'hazeAdj': {'distance': 0.1, 'slope': 0.2},
      'highlightsAndShadows': {'highlights': 0.1, 'shadows': 0.2},
      'opacityAdj': {'opacity': 0.2},
      'saturationAdj': {'saturation': 0.2},
      'vibranceAdj': {'vibrance': 0.2},
      'vignetteAdj': {'positionX': 0.1, 'positionY': 0.2, 'colorRed': 0.1, 'colorGreen': 0.1, 'colorBlue': 0.1, 'start': 0.0, 'end': 0.1}
    }
  };
  List baseFilters = [];

  @override
  void initState() {
    super.initState();
    _init(params['params']);
  }

  _init(Map<String, Map> data) {
    data.forEach((key, value) {
      switch (key) {
        case 'brightnessAdj':
          final brightnessAdjustment = BrightnessAdjustment(value: value['brightness']);
          baseFilters.add(brightnessAdjustment);
          break;
        case 'contrastAdj':
          final contrastAdjustment = ContrastAdjustment(value: value['contrast']);
          baseFilters.add(contrastAdjustment);
          break;
        case 'rgbAdj':
          final rgbAdjustment = RGBAdjustment(red: value['red'], green: value['green'], blue: value['blue']);
          baseFilters.add(rgbAdjustment);
          break;
        case 'exposureAdj':
          final exposureAdjustment = ExposureAdjustment(value: value['exposure']);
          baseFilters.add(exposureAdjustment);
          break;
        case 'gaussianBlur':
          final gaussianBlurAdjustment = GaussianBlur(blurRadiusInPixels: value['blurRadiusInPixels']);
          baseFilters.add(gaussianBlurAdjustment);
          break;
        case 'hazeAdj':
          final hazeAdjustment = Haze(distance: value['distance'], slope: value['slope']);
          baseFilters.add(hazeAdjustment);
          break;
        case 'highlightsAndShadows':
          final highlightsAndShadows = HighlightsAndShadows(highlights: value['highlights'], shadows: value['shadows']);
          baseFilters.add(highlightsAndShadows);
          break;
        case 'opacityAdj':
          final opacityAdjustment = OpacityAdjustment(opacity: value['opacity']);
          baseFilters.add(opacityAdjustment);
          break;
        case 'saturationAdj':
          final saturationAdjustment = SaturationAdjustment(value: value['saturation']);
          baseFilters.add(saturationAdjustment);
          break;
        case 'vibranceAdj':
          final vibranceAdjustment = Vibrance(value: value['vibrance']);
          baseFilters.add(vibranceAdjustment);
          break;
        case 'vignetteAdj':
          final vignetteAdjustment = Vignette(
              positionX: value['positionX'],
              positionY: value['positionY'],
              colorRed: value['colorRed'],
              colorGreen: value['colorGreen'],
              colorBlue: value['colorBlue'],
              start: value['start'],
              end: value['end']);
          baseFilters.add(vignetteAdjustment);
          break;
      }
    });

    print(baseFilters);
  }

  getTestValue() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                onPressed: () async {
                  final sourceImage = await rootBundle.load('assets/images/1629819276523.jpg');
                  // final sourceImage =
                  //     await rootBundle.load('assets/images/IMG_0945.JPG');

                  final lookupImage = await rootBundle.load('assets/images/lookup1.jpg');
                  List filters = [];
                  params['params'].forEach((key, value) {
                    if (key == 'brightnessAdj') {
                      final brightnessAdjustment = BrightnessAdjustment(value: value['brightness']);
                      filters.add(brightnessAdjustment);
                    } else if (key == 'exposureAdj') {
                      final exposureAdjustment = ExposureAdjustment(value: value['exposure']);
                      filters.add(exposureAdjustment);
                    }
                  });
                  final lookupFilter = GPUImageLookupFilter(filterImage: lookupImage.buffer.asUint8List());
                  final brightnessAdjustment = BrightnessAdjustment(value: 0);
                  final gaussianBlur =  GaussianBlur(blurRadiusInPixels: 12.0);
                  // final exposureAdjustment = Vignette(positionX: -1.0, positionY: 1.0, start: 0.5, end: 0.75);
                  final res = await FlutterGpuimage.progressImage(sourceImage: lookupImage.buffer.asUint8List(), filters: [gaussianBlur]);
                  final overlayBlend = OverlayBlend(blendImage: res);
                  final result = await FlutterGpuimage.progressImage(sourceImage: sourceImage.buffer.asUint8List(), filters: [overlayBlend]);
                  setState(() {
                    _image = result;
                  });
                },
                child: Text(
                  '图片$testValue',
                  style: TextStyle(color: Colors.purple),
                )),
            _image == null
                ? Container(
                    width: 200,
                    height: 200,
                    color: Colors.deepOrange,
                  )
                : Image.memory(
                    _image,
                    width: 300,
                    height: 400,
                  ),
          ],
        ),
      ),
    );
  }
}
