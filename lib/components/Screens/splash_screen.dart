import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/AppLogo/app_logo.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';

import 'Onboarding/onboarding_start.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => OnboardingStart());
    });
  }

  final Shader linearGradient = LinearGradient(
    begin: FractionalOffset.topCenter,
    colors: <Color>[HexColor.fromHex("#76C4AE"), HexColor.fromHex("#BEE9E4")],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 30.0, 40.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DarkRadialBackground(
          color: HexColor.fromHex("#181a1f"),
          position: "topLeft",
        ),
        AppLogo(),
        Center(
            child: Container(
          child: RichText(
            text: TextSpan(
              text: 'My',
              style: GoogleFonts.montserrat(fontSize: 60, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: 'ey',
                    style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        )),
        // DarkRadialBackground(
        //   color: Colors.transparent,
        //   position: "bottomRight",
        // ),
      ]),
    );
  }
}
