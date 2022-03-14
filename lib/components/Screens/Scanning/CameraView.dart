import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/BottomSheets/bottom_sheets.dart';
import 'package:myey/components/Data/data_model.dart';
import 'package:myey/components/Screens/Chat/messaging_screen.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Buttons/primary_buttons.dart';
import 'package:myey/components/widgets/Chat/post_bottom_widget.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Dashboard/in_bottomsheet_subtitle.dart';
import 'package:myey/components/widgets/Dashboard/sheet_goto_calendar.dart';
import 'package:myey/components/widgets/Navigation/back_button.dart';
import 'package:myey/components/widgets/Notification/notification_card.dart';
import 'package:myey/components/widgets/Projects/project_badge.dart';
import 'package:myey/components/widgets/Projects/project_selectable_container.dart';
import 'package:myey/components/widgets/dummy/profile_dummy.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  bool isFaceInView = false;
  double viewWidth = Utils.screenWidth;
  double viewHeight = Utils.screenWidth;
  double viewRadius = 0.0;

  void setFaceInFocus() {
    if (!isFaceInView) {
      setState(() {
        viewHeight = 300.0;
        viewWidth = 300.0;
        viewRadius = 300;
        isFaceInView = true;
      });
    } else {
      setState(() {
        viewHeight = Utils.screenHeight;
        viewWidth = Utils.screenWidth;
        viewRadius = 0.0;
        isFaceInView = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      DarkRadialBackground(
        color: HexColor.fromHex("#181a1f"),
        position: "topLeft",
      ),

      // listView
      Positioned(
          top: 80,
          child: Container(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              width: Utils.screenWidth,
              height: Utils.screenHeight * 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        width: Utils.screenWidth,
                        height: Utils.screenHeight,
                        child: Stack(
                          children: [
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Container(
                            //     width: Utils.screenWidth,
                            //     height: Utils.screenHeight,
                            //     decoration: BoxDecoration(
                            //       color: Colors.red,
                            //     ),
                            //   ),
                            // ),
                            Align(
                              alignment: Alignment.center,
                              child: AnimatedContainer(
                                width: viewWidth,
                                height: viewHeight,
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.7),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(viewRadius))),
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: AnimatedOpacity(
                                opacity: isFaceInView ? 1 : 0,
                                duration: Duration(
                                    milliseconds: isFaceInView ? 1500 : 250),
                                child: Container(
                                  width: 320,
                                  height: 320,
                                  margin: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(
                                    value: 0,
                                    strokeWidth: 20,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                        width: Utils.screenWidth,
                        padding: EdgeInsets.all(44),
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
                                )),
                          ],
                        )),
                    AppPrimaryButton(
                        buttonHeight: 50,
                        buttonWidth: 200,
                        buttonText: "Face Focus",
                        callback: () {
                          setFaceInFocus();
                        }),
                    AppSpaces.verticalSpace10,
                  ]))),

      Positioned(
        top: 0,
        child: Container(
          child: ClipRect(
            child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 20),
              child: Container(
                width: Utils.screenWidth,
                padding: EdgeInsets.all(20),
                height: 120.0,
                decoration: new BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBackButton(),
                        Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                              IconButton(
                                icon: Icon(Icons.more_horiz),
                                color: Colors.white,
                                iconSize: 30,
                                onPressed: () {
                                  showSettingsBottomSheet();
                                },
                              )
                            ]))
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
      //last widget
      // PostBottomWidget(label: "Post your comments...")
    ]));
  }
}
