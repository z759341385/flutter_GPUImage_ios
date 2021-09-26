import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gpuimage/flutter_gpuimage.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List _image;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/1351631461463.jpg').then((value) {
      setState(() {
        _image = value.buffer.asUint8List();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? SizedBox.shrink() : Expanded(
              child: Image.memory(
                _image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            FlatButton(
                onPressed: () async {
                  final lookupImage =
                      await rootBundle.load('assets/images/lookup-table-pta.png');
                  final lookupFilter = GPUImageLookupFilter(
                      filterImage: lookupImage.buffer.asUint8List());
                  final result = await FlutterGpuimage.progressImage(
                      sourceImage: _image,
                      filters: [lookupFilter]);
                  setState(() {
                    _image = result;
                  });
                },
                child: Text(
                  '添加滤镜',
                  style: TextStyle(color: Colors.purple),
                )),
          ],
        ),
      ),
    );
  }
}
