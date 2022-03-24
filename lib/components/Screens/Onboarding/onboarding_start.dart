import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Screens/Onboarding/onboarding_carousel.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Onboarding/background_image.dart';
import 'package:myey/components/widgets/Onboarding/bubble.dart';
import 'package:myey/components/widgets/Onboarding/loading_stickers.dart';
import 'dart:math' as math;

import 'package:myey/components/widgets/Shapes/background_hexagon.dart';

class OnboardingStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DarkRadialBackground(
          color: HexColor.fromHex("#181a1f"),
          position: "topLeft",
        ),

        Positioned(
            top: Utils.screenHeight,
            left: 0,
            child: Transform.rotate(angle: -math.pi / 2, child: CustomPaint(painter: BackgroundHexagon()))),
        //images
        Positioned(
            top: Utils.screenHeight * 0.7,
            right: 100,
            child: BackgroundImage(
                scale: 1.0,
                image: "assets/icon/logo.png",
                gradient: [HexColor.fromHex("ffffff").withOpacity(0), HexColor.fromHex("ffffff").withOpacity(0)])),

        Positioned(
            top: Utils.screenHeight * 0.50,
            left: Utils.screenWidth * 0.12,
            child: BackgroundImage(
                scale: 0.5,
                image: "assets/icon/logo.png",
                gradient: [HexColor.fromHex("ffffff").withOpacity(0), HexColor.fromHex("ffffff").withOpacity(0)])),

        Positioned(
            top: Utils.screenHeight * 0.20,
            right: 180,
            child: BackgroundImage(
                scale: 0.4,
                image: "assets/icon/logo.png",
                gradient: [HexColor.fromHex("ffffff").withOpacity(0), HexColor.fromHex("ffffff").withOpacity(0)])),

        //end of images

        //Bubble
        Positioned(top: 80, left: 50, child: Bubble(1.0, HexColor.fromHex("76C4AE"))),

        Positioned(top: 130, left: 130, child: Bubble(0.6, HexColor.fromHex("76C4AE"))),
        //end bubble

        Positioned(
            top: Utils.screenHeight * 0.12,
            left: Utils.screenWidth * 0.45,
            child: LoadingSticker(
                gradients: [HexColor.fromHex("#F3EEAE"), HexColor.fromHex("F3EFAB"), HexColor.fromHex("#4A88FE")])),
        Positioned(
            top: Utils.screenHeight * 0.50,
            left: Utils.screenWidth * 0.22,
            child: LoadingSticker(gradients: [HexColor.fromHex("#a7b2fd"), HexColor.fromHex("#c1a0fd")])),
        Positioned(
            top: Utils.screenHeight * 0.7,
            left: Utils.screenWidth * 0.6,
            child: LoadingSticker(gradients: [HexColor.fromHex("#a7b2fd"), HexColor.fromHex("#c1a0fd")])),
        Positioned(
            top: Utils.screenHeight * 1.3,
            left: Utils.screenWidth * 0.83,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: InkWell(
                onTap: () {
                  Get.to(() => OnboardingCarousel());
                },
                child: Container(
                    width: 200,
                    height: 200,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50.0), color: HexColor.fromHex("B6FFE5")),
                    child: Transform.rotate(
                      angle: math.pi / 4,
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top: 80, left: 30),
                          child: Icon(Icons.arrow_forward, size: 40)),
                    )),
              ),
            )),

        Positioned(
            bottom: 150,
            left: 40,
            child: Container(
              width: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Eye testing become easy 🙌',
                        style: GoogleFonts.lato(fontSize: 18, color: HexColor.fromHex("76C4AE")),
                      ),
                    ),
                    Text('Lets test\nour eyes for\na healthy life',
                        style: GoogleFonts.lato(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                    AppSpaces.verticalSpace20,
                    Container(
                      width: 180,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => OnboardingCarousel());
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(HexColor.fromHex("76C4AE")),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(color: HexColor.fromHex("76C4AE"))))),
                          child: Center(
                              child: Text('Get Started', style: GoogleFonts.lato(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)))),
                    )
                  ]),
            ))
      ]),
    );
  }
}
