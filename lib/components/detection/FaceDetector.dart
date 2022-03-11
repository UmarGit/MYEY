import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
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
  bool _doneWithRef = false;

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
    _doneWithRef = true;
  }

  /*/
    Calculating the distance using all the values
   */
  double getDistance() {
    try {
      double screenToFaceDistance = ((P_REF / P_SF) * D_REF);
      //converting millimeter to foot
      double toFeet = screenToFaceDistance / 305;
      return toFeet;
    } catch (e) {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double distance = getDistance();
    bool inRange = distance > 1.7 && distance < 2.0;
    return Scaffold(
      body: Stack(
        children: [
          //tried hiding cameraView with indexedStack but it stopped updating distance
          // IndexedStack(index: inRange ? 1 : 0, children: [
            CameraView(
              title: 'Face Detector',
              customPaint: customPaint,
              onImage: (inputImage) {
                processImage(inputImage);
              },
              initialDirection: CameraLensDirection.front,
            ),
            // SizedBox(
            //   child: Container(decoration: BoxDecoration(color: Colors.yellow)),
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            // ),
          // ]),
          //when the app takes the reference pictures oval shape for face disappears
          _doneWithRef
              ? Container()
              : ColorFiltered(
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
                        style: TextStyle(
                            color: Colors.white, backgroundColor: Colors.black),
                      )
                    : const Text(
                        "Position your face",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 160),
            child: Text(
              getDistance().toStringAsFixed(4) + ' feet',
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
