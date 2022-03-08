// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:myey/components/detection/FaceDetector.dart';
import 'package:myey/components/listen/Listen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const OnBoarding(),
    );
  }
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  void _startScanning() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FaceDetectorView()));
  }

  void _startListening() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Listen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildImage('logo.png'),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(children: const [
                    Text(
                      'Welcome to Myey App',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'By GDSC IUK',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ]),
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => _startScanning(),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: const Text(
                                'Start Scanning',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () => _startListening(),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: const Text(
                                'Start Listening',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
