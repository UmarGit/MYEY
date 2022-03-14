import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Buttons/primary_progress_button.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Forms/form_input_with%20_label.dart';
import 'package:myey/components/widgets/Navigation/app_header.dart';
import 'package:myey/components/widgets/dummy/profile_dummy.dart';

class EditProfilePage extends StatelessWidget {
  final String tabSpace = "\t\t\t";
  EditProfilePage({Key? key}) : super(key: key);

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _roleController = new TextEditingController();
  TextEditingController _aboutController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      DarkRadialBackground(
        color: HexColor.fromHex("#181a1f"),
        position: "topLeft",
      ),
      Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            myey_appAppHeader(
              title: "$tabSpace Edit Profile",
              widget: PrimaryProgressButton(
                width: 80,
                height: 40,
                label: "Done",
                textStyle: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Stack(
              children: [
                ProfileDummy(
                    color: HexColor.fromHex("94F0F1"),
                    dummyType: ProfileDummyType.Image,
                    scale: 3.0,
                    image: "assets/man-head.png"),
                Container(
                    width: 120,
                    height: 120,
                    decoration:
                        BoxDecoration(color: AppColors.primaryAccentColor.withOpacity(0.75), shape: BoxShape.circle),
                    child: Icon(FeatherIcons.camera, color: Colors.white, size: 20))
              ],
            ),
            AppSpaces.verticalSpace20,
            LabelledFormInput(
                placeholder: "Blake Gordon",
                keyboardType: "text",
                controller: _nameController,
                obscureText: false,
                label: "Your Name"),
            AppSpaces.verticalSpace20,
            LabelledFormInput(
                placeholder: "blake@gmail.com",
                keyboardType: "text",
                controller: _emailController,
                obscureText: true,
                label: "Your Email"),
            AppSpaces.verticalSpace20,
            LabelledFormInput(
                placeholder: "HikLHjD@&1?>",
                keyboardType: "text",
                controller: _passController,
                obscureText: true,
                label: "Your Password"),
            AppSpaces.verticalSpace20,
            LabelledFormInput(
                placeholder: "Visual Designer",
                keyboardType: "text",
                controller: _roleController,
                obscureText: true,
                label: "Role"),
            AppSpaces.verticalSpace20,
            LabelledFormInput(
                placeholder: "Design & Cat Person",
                keyboardType: "text",
                controller: _aboutController,
                obscureText: true,
                label: "About Me"),
          ]))))
    ]));
  }
}
