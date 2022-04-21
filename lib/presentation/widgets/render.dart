import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'package:workout/presentation/widgets/camera.dart';
import 'package:workout/presentation/widgets/keypointer.dart';

class Render extends StatefulWidget {
  final List<CameraDescription> cameras;

  Render(this.cameras);

  @override
  _RenderState createState() => new _RenderState();
}

class _RenderState extends State<Render> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  Future<String> _loadModel() async =>
    await Tflite.loadModel(
        model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");

  _setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<String>(
          future: _loadModel(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Camera(widget.cameras, _setRecognitions),
                  Keypointer(
                      _recognitions == null ? [] : _recognitions,
                      math.max(_imageHeight, _imageWidth),
                      math.min(_imageHeight, _imageWidth),
                      screen.height,
                      screen.width),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
