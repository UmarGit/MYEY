// ignore_for_file: file_names

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../camera/CameraView.dart';
import 'painter/FaceDetectorPainter.dart';

int P_SF = 0;

List<int> faceSize = [];

int center = 0;

Set onDistances(distances) => {
      P_SF = distances[0],
      faceSize = [distances[1], distances[2]],
      center = distances[3],
    };

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
  bool _doneWithRef = false;
  bool isCalibrated = false;
  int measurements = 0;

  /// declare a timer
  Timer? timer;

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
    timer?.cancel();
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
    _doneWithRef = true;
  }

  void getMeasurements() {
    timer = Timer.periodic(
      const Duration(seconds: 20),
      (tim) {
        if (measurements >= 10) {
          P_REF = P_REFS.reduce((value, element) => value + element) ~/
              P_REFS.length;
          _doneWithRef = true;
          timer?.cancel();
        } else {
          P_REFS.add(P_SF);
          setState(() {
            measurements++;
            isCalibrated = true;
          });
        }
      },
    );
  }

  /*/
    Calculating the distance using all the values
   */
  double getDistance() {
    try {
      double screenToFaceDistance = ((P_REF / P_SF) * D_REF);
      //converting millimeter to foot
      double toCm = screenToFaceDistance / 10;
      return toCm;
    } catch (e) {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double distance = getDistance();
    bool inRange = distance > 40 && distance < 65.00;
    bool canCalibrate = faceSize.isNotEmpty
        ? ((faceSize[0] * 3.779528).toInt() - 100) > 400 &&
            ((faceSize[1] * 3.779528).toInt() - 100) > 300
        : false;

    if (canCalibrate && !isCalibrated && center > 130 && center < 150) {
      P_REFS = [];
      getMeasurements();
    }

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
          _doneWithRef
              ? AnimatedContainer(
                  width: double.infinity,
                  height: double.infinity,
                  decoration:
                      BoxDecoration(color: inRange ? Colors.green : Colors.red),
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(1),
                          BlendMode.srcOut), // This one will create the magic
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              backgroundBlendMode: BlendMode.dstOut,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: const EdgeInsets.only(top: 100),
                              child: Container(
                                height: 400,
                                width: 300,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(400)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 100),
                        child: Container(
                          height: 400,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(400)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 100),
                          child: CircularProgressIndicator(
                            value: ((measurements / 10) * 100),
                            semanticsLabel: 'Linear progress indicator',
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(measurements.toString() + '\n\n\n',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: _doneWithRef
                    ? const Text(
                        "Position your phone 2 feet away from you",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        "Position your face ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ],
          ),
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   margin: const EdgeInsets.only(bottom: 160),
          //   child: Text(
          //     getDistance().toStringAsFixed(2) + ' cm',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 32,
          //       color: inRange ? Colors.black : Colors.brown,
          //     ),
          //   ),
          // ),
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
