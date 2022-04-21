import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'home.dart';

List<CameraDescription> cameras;
Color primaryColor = Color(0xFFFF4131);
Color secondaryColor = Color(0xFFFF7624);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: primaryColor,
    systemNavigationBarIconBrightness: Brightness.light
  ));

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: primaryColor,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      home: HomePage(cameras),
    );
  }
}
