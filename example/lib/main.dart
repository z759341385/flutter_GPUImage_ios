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
  Uint8List _image;
  int testValue;
  @override
  void initState() {
    super.initState();
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
                  final lookupFilter = GPUImageLookupFilter(filterImage: lookupImage.buffer.asUint8List());
                  // final brightnessAdjustment = BrightnessAdjustment(value: 0);
                  final exposureAdjustment = Vibrance(value: -1.2);
                  final result = await FlutterGpuimage.progressImage(
                      sourceImage: sourceImage.buffer.asUint8List(), filters: [lookupFilter, exposureAdjustment]);
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
                    width: 200,
                    height: 200,
                  ),
          ],
        ),
      ),
    );
  }
}
