import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Screens/Dashboard/timeline.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Forms/form_input_with%20_label.dart';
import 'package:myey/components/widgets/Navigation/back.dart';

class Login extends StatefulWidget {
  final String email;

  const Login({Key? key, required this.email}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passController = TextEditingController();
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      content: const Text('Please enter correct password to continue'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primaryAccentColor,
    );

    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: HexColor.fromHex("#181a1f"),
            position: "topLeft",
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NavigationBack(),
                  const SizedBox(height: 40),
                  Text(
                    'Login',
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  AppSpaces.verticalSpace20,
                  RichText(
                    text: TextSpan(
                      text: 'Using  ',
                      style: GoogleFonts.lato(
                        color: HexColor.fromHex("676979"),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "  to login.",
                          style: GoogleFonts.lato(
                            color: HexColor.fromHex("676979"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  LabelledFormInput(
                      placeholder: "Password",
                      keyboardType: "text",
                      controller: _passController,
                      obscureText: obscureText,
                      label: "Your Password"),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_passController.text == 'myey@123') {
                          Get.to(() => Timeline(
                                selectedIndex: ValueNotifier(0),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ButtonStyles.blueRounded,
                      child: Text(
                        'Sign In',
                        style:
                            GoogleFonts.lato(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
