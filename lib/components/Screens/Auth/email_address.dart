import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Screens/Auth/login.dart';
import 'package:myey/components/Screens/Dashboard/timeline.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Forms/form_input_with%20_label.dart';
import 'package:myey/components/widgets/Navigation/back.dart';
import 'package:myey/components/widgets/Shapes/background_hexagon.dart';

class EmailAddressScreen extends StatefulWidget {
  const EmailAddressScreen({Key? key}) : super(key: key);

  @override
  _EmailAddressScreenState createState() => _EmailAddressScreenState();
}

class _EmailAddressScreenState extends State<EmailAddressScreen> {
  final TextEditingController _passController = TextEditingController();

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      content: const Text('Enter correct email & password'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primaryAccentColor,
    );

    return Scaffold(
        body: Stack(children: [
      DarkRadialBackground(
        color: HexColor.fromHex("#181a1f"),
        position: "topLeft",
      ),
      Positioned(
          top: Utils.screenHeight / 2,
          left: Utils.screenWidth,
          child: Transform.rotate(
              angle: -math.pi / 2,
              child: CustomPaint(painter: BackgroundHexagon()))),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const NavigationBack(),
          const SizedBox(height: 40),
          Text("Login",
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          AppSpaces.verticalSpace20,
          LabelledFormInput(
              placeholder: "Password",
              keyboardType: "text",
              controller: _passController,
              obscureText: obscureText,
              label: "Your Password"),
          const SizedBox(height: 40),
          Container(
            //width: 180,
            height: 60,
            child: ElevatedButton(
                onPressed: () {
                  if (_passController.text == 'admin') {
                    Get.to(() => Timeline(
                          selectedIndex: ValueNotifier(0),
                        ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ButtonStyles.blueRounded,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, color: Colors.white),
                    Text('   Continue with Email',
                        style: GoogleFonts.lato(
                            fontSize: 20, color: Colors.white)),
                  ],
                )),
          )
        ])),
      )
    ]));
  }
}
