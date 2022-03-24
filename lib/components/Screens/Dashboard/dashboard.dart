import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/BottomSheets/bottom_sheets.dart';
import 'package:myey/components/Screens/Chat/chat_screen.dart';
import 'package:myey/components/Screens/Profile/profile_overview.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/BottomSheets/dashboard_settings_sheet.dart';
import 'package:myey/components/widgets/Buttons/primary_tab_buttons.dart';
import 'package:myey/components/widgets/Navigation/dasboard_header.dart';
import 'package:myey/components/widgets/Shapes/app_settings_icon.dart';

import 'DashboardTabScreens/overview.dart';
import 'DashboardTabScreens/productivity.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final ValueNotifier<bool> _totalTaskTrigger = ValueNotifier(true);
  final ValueNotifier<bool> _totalDueTrigger = ValueNotifier(false);
  final ValueNotifier<bool> _totalCompletedTrigger = ValueNotifier(true);
  final ValueNotifier<bool> _workingOnTrigger = ValueNotifier(false);
  final ValueNotifier<int> _buttonTrigger = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DashboardNav(
                icon: FontAwesomeIcons.userCircle,
                notificationCount: "2",
                title: "Dashboard",
                onImageTapped: () {
                  Get.to(() => const ProfileOverview());
                },
              ),
              AppSpaces.verticalSpace20,
              Text("Hello,\nUmar Ahmed...",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              AppSpaces.verticalSpace20,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //tab indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryTabButton(
                        buttonText: "Reports",
                        itemIndex: 0,
                        notifier: _buttonTrigger),
                    PrimaryTabButton(
                        buttonText: "Overview",
                        itemIndex: 1,
                        notifier: _buttonTrigger),
                  ],
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: AppSettingsIcon(
                      callback: () {
                        showAppBottomSheet(
                          DashboardSettingsBottomSheet(
                            totalTaskNotifier: _totalTaskTrigger,
                            totalDueNotifier: _totalDueTrigger,
                            workingOnNotifier: _workingOnTrigger,
                            totalCompletedNotifier: _totalCompletedTrigger,
                          ),
                        );
                      },
                    ))
              ]),
              AppSpaces.verticalSpace20,
              ValueListenableBuilder(
                  valueListenable: _buttonTrigger,
                  builder: (BuildContext context, _, __) {
                    return _buttonTrigger.value == 0
                        ? const DashboardProductivity()
                        : const DashboardOverview();
                  })
            ]),
          ),
        ));
  }
}
