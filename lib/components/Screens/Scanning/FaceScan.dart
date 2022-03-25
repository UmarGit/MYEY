import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/BottomSheets/bottom_sheets.dart';
import 'package:myey/components/Screens/EyeTest/TakeTest.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/camera/CameraView.dart';
import 'package:myey/components/detection/painter/FaceDetectorPainter.dart';
import 'package:myey/components/widgets/Buttons/primary_buttons.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Navigation/back_button.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:we_slide/we_slide.dart';

int _eyeToEyeContinuous = 0;
List<int> _faceSize = [];
// int _centerOfFace = 0;

void onDistances(distances) {
  _eyeToEyeContinuous = distances[0];
  _faceSize = [distances[1], distances[2]];
  // _centerOfFace = distances[3];
}

class FaceScan extends StatefulWidget {
  const FaceScan({Key? key}) : super(key: key);

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan> with TickerProviderStateMixin {
  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;
  CustomPaint? customPaint;
  bool _isFaceInView = false;
  double _viewWidth = Utils.screenWidth;
  double _viewHeight = Utils.screenWidth;
  double _viewRadius = 0.0;
  late AnimationController _radiusAnimation;
  bool _isCalibrated = false;
  bool _isMeasurementStarted = false;
  int _measurements = 0;
  List<int> _eyeToEyeReferences = [];
  int _eyeToEyeReference = 0;
  final int _distanceOfReferenceObject = 294;
  late Timer timer;
  bool _isDetectionEnabled = false;

  void setFaceInFocus() {
    if (!_isFaceInView) {
      setState(() {
        _viewHeight = 300.0;
        _viewWidth = 300.0;
        _viewRadius = 300;
        _isFaceInView = true;
      });
      _radiusAnimation.forward();
    } else {
      setState(() {
        _viewHeight = Utils.screenHeight;
        _viewWidth = Utils.screenWidth;
        _viewRadius = 0.0;
        _isFaceInView = false;
      });
      _radiusAnimation.reverse();
    }
  }

  void measureRef() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_measurements >= 10) {
        timer.cancel();
        setState(() {
          _eyeToEyeReference =
              _eyeToEyeReferences.reduce((value, element) => value + element) ~/
                  _eyeToEyeReferences.length;
          _isCalibrated = true;
        });
      } else {
        _eyeToEyeReferences.add(_eyeToEyeContinuous);
        setState(() {
          _measurements = _measurements + 1;
        });
      }
    });
  }

  double getDistance() {
    try {
      double screenToFaceDistance =
          ((_eyeToEyeReference / _eyeToEyeContinuous) *
              _distanceOfReferenceObject);
      double toCm = screenToFaceDistance / 10;
      return toCm;
    } catch (e) {
      return -1;
    }
  }

  @override
  void initState() {
    _radiusAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      animationBehavior: AnimationBehavior.preserve,
      lowerBound: 0,
      upperBound: 300,
    )..addListener(() {
        setState(() {});
      });
    setState(() {
      _isDetectionEnabled = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    try {
      timer.cancel();
    } catch (e) {
      // print("Timer Not Init");
    }
    setState(() {
      _isDetectionEnabled = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double distance = getDistance();
    bool canCalibrate = _faceSize.isNotEmpty
        ? ((_faceSize[0] * 3.779528).toInt() - 100) > 400 &&
            ((_faceSize[1] * 3.779528).toInt() - 100) > 300
        : false;

    if (canCalibrate && !_isCalibrated && !_isMeasurementStarted) {
      setFaceInFocus();
      _eyeToEyeReferences = [];
      measureRef();
      setState(() {
        _isMeasurementStarted = true;
      });
    }
    final WeSlideController _slideController = WeSlideController();
    const double _panelMinSize = 70.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height - 40;

    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: HexColor.fromHex("#181a1f"),
            position: "topLeft",
          ),

          // listView
          Positioned(
            top: 80,
            child: WeSlide(
              controller: _slideController,
              panelMinSize: _panelMinSize,
              panelMaxSize: _panelMaxSize,
              overlayOpacity: 1,
              overlay: true,
              isDismissible: true,
              body: Container(
                  padding: const EdgeInsets.only(top: 40),
                  width: Utils.screenWidth,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: Utils.screenWidth,
                          height: Utils.screenHeight,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  width: _viewWidth,
                                  height: _viewHeight,
                                  decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_viewRadius))),
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        _radiusAnimation.value),
                                    child: Stack(
                                      children: [
                                        AnimatedOpacity(
                                          opacity: !_isCalibrated ? 1 : 0.5,
                                          duration: const Duration(seconds: 1),
                                          child: _isDetectionEnabled
                                              ? CameraView(
                                                  title: 'Face Detector',
                                                  customPaint: customPaint,
                                                  onImage: (inputImage) {
                                                    processImage(inputImage);
                                                  },
                                                  initialDirection:
                                                      CameraLensDirection.front,
                                                )
                                              : Container(),
                                        ),
                                        AnimatedOpacity(
                                          opacity: _isCalibrated ? 1 : 0,
                                          duration: const Duration(seconds: 1),
                                          child: Center(
                                            child: Container(
                                              width: Utils.screenWidth,
                                              height: Utils.screenHeight,
                                              color: Colors.green[400],
                                              child: Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Colors.green[100],
                                                size: 200,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: AnimatedOpacity(
                                  opacity: _isFaceInView ? 1 : 0,
                                  duration: Duration(
                                      milliseconds: _isFaceInView ? 1500 : 250),
                                  child: Container(
                                    width: 320,
                                    height: 320,
                                    margin: const EdgeInsets.all(20),
                                    child: CircularProgressIndicator(
                                      value: _measurements / 10,
                                      strokeWidth: 20,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: Utils.screenWidth,
                          padding: const EdgeInsets.all(44),
                          child: Column(
                            children: [
                              _isCalibrated
                                  ? LinearProgressIndicator(
                                      value: (getDistance() / 60),
                                      color: (getDistance() / 60) >= 0.9
                                          ? Colors.green
                                          : Colors.red,
                                      semanticsLabel:
                                          'Distance between face and camera',
                                    )
                                  : Container(),
                              AppSpaces.verticalSpace10,
                              Text(
                                  _isCalibrated
                                      ? (getDistance() / 60) >= 0.9
                                          ? "Perfect now click on start test"
                                          : "Move away your camera"
                                      : "Align your face",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              AppSpaces.verticalSpace10,
                              Text(
                                _isCalibrated
                                    ? "Please move your camera away upto two feet from your phone"
                                    : "Make sure you are sitting in a room with proper lighting",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpaces.verticalSpace10,
                      ])),
              panel: (getDistance() / 60) >= 0.9
                  ? TakeTest(distance: distance)
                  : Container(
                      child: Center(
                        child: Text(
                          'Move the camera away from your phone',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ),

          Positioned(
            top: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 20),
                child: Container(
                  width: Utils.screenWidth,
                  padding: const EdgeInsets.all(20),
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppBackButton(),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (getDistance() / 60) >= 0.9 && _isCalibrated
                                  ? AppPrimaryButton(
                                      buttonHeight: 40,
                                      buttonWidth: 120,
                                      buttonText: "Start Test",
                                      callback: () {
                                        _slideController.show();
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
