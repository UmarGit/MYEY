// ignore_for_file: file_names

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:myey/main.dart';
import '../camera/CameraView.dart';
import 'painter/FaceDetectorPainter.dart';

int P_SF = 0;

Set onDistance(dist) => {P_SF = dist};

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({Key? key}) : super(key: key);

  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;
  CustomPaint? customPaint;

  /*/
    P_REFS is the multiple distances, 10 times with different
    Eye to Eye distances
   */
  List<int> P_REFS = [];

  /*/
    P_REF is the mean average of P_REFS
   */
  int P_REF = 0;

  /*/
    D_REF is the constant or boundary of capturing reference
    eye to eye distances
   */
  int D_REF = 294;

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  /*/
    Here we record 10 values of Distances between eyes
   */
  void measureRef() {
    P_REFS = [];
    for (int index = 0; index <= 10; index++) {
      P_REFS.add(P_SF);
    }

    P_REF = P_REFS.reduce((value, element) => value + element) ~/ P_REFS.length;
  }

  /*/
    Calculating the distance using all the values
   */
  double getDistance() {
    try {
      double SCREEN_TO_FACE_DISTANCE = ((P_REF / P_SF) * D_REF);
      double TO_FOOT = SCREEN_TO_FACE_DISTANCE / 305;
      return TO_FOOT;
    } catch (e) {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double DISTANCE = getDistance();
    bool inRange = DISTANCE > 1.7 && DISTANCE < 2.0;

    return Scaffold(
      body: Stack(
        children: [
          CameraView(
            title: 'Face Detector',
            customPaint: customPaint,
            onImage: (inputImage) {
              processImage(inputImage);
            },
            initialDirection: CameraLensDirection.front,
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(1),
                BlendMode.srcOut), // This one will create the magic
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      backgroundBlendMode: BlendMode.dstOut),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: ClipOval(
                      child: Container(
                        height: 440,
                        width: 240,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 160),
            child: Text(
              getDistance().toStringAsFixed(4) + ' foot',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: inRange ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => measureRef(),
            child: const Icon(Icons.compare_arrows),
          )
        ],
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
