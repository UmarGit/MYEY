import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Screens/Scanning/FaceScan.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Buttons/primary_buttons.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Navigation/back_button.dart';

class ScanGuide extends StatefulWidget {
  const ScanGuide({Key? key}) : super(key: key);

  @override
  State<ScanGuide> createState() => _ScanGuideState();
}

class _ScanGuideState extends State<ScanGuide> with TickerProviderStateMixin {
  int scannedValue = 0;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      animationBehavior: AnimationBehavior.preserve,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              width: Utils.screenWidth,
              height: Utils.screenHeight * 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: Utils.screenWidth,
                    height: Utils.screenHeight,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(300))),
                            child: Icon(
                              Icons.face,
                              color: Colors.green[100],
                              size: 200,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 320,
                            height: 320,
                            margin: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              value: controller.value,
                              strokeWidth: 20,
                              color: Colors.green[500]
                                  ?.withOpacity(controller.value),
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
                        Text("How to Calibrate Your Face",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        AppSpaces.verticalSpace10,
                        Text(
                          "First, position your face in the camera frame. Then wait for 10 seconds in the frame to capture accurate readings",
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
                ],
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
                        AppPrimaryButton(
                            buttonHeight: 40,
                            buttonWidth: 120,
                            buttonText: "Get Started",
                            callback: () {
                              Get.to(() => const FaceScan());
                            }),
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
}
