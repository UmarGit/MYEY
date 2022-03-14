import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Constants/constants.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Buttons/primary_progress_button.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Navigation/app_header.dart';
import 'package:myey/components/widgets/Onboarding/labelled_option.dart';
import 'package:myey/components/widgets/container_label.dart';

class ProfileNotificationSettings extends StatelessWidget {
  ValueNotifier<bool> _assignmedToMe = ValueNotifier(true);
  ValueNotifier<bool> _taskCompleted = ValueNotifier(false);
  ValueNotifier<bool> _mentionedMe = ValueNotifier(true);
  ValueNotifier<bool> _directMessage = ValueNotifier(false);

  ProfileNotificationSettings({Key? key}) : super(key: key);

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
              title: "$tabSpace Notifications",
              widget: PrimaryProgressButton(
                width: 80,
                height: 40,
                label: "Done",
                textStyle: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            AppSpaces.verticalSpace40,
            Container(
                width: double.infinity,
                height: Utils.screenHeight * 0.9,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryBackgroundColor),
                child: Column(children: [
                  LabelledOption(
                    label: '30 minutes',
                    icon: Icons.lock_clock,
                  ),
                  LabelledOption(
                    label: '1 hour',
                    icon: Icons.lock_clock,
                  ),
                  LabelledOption(
                    label: 'Until Tomorrow',
                    icon: Icons.calendar_today,
                  ),
                  LabelledOption(
                    label: 'Until next 2 days',
                    icon: Icons.calendar_today,
                  ),
                  LabelledOption(
                    label: 'Custom',
                    icon: Icons.calendar_today,
                  ),
                ])),
            AppSpaces.verticalSpace40,
            ContainerLabel(label: "NOTIFY MY ABOUT"),
            AppSpaces.verticalSpace40,
            LabelledCheckbox(
              label: "Task assigned to me",
              notifierValue: _assignmedToMe,
            ),
            LabelledCheckbox(label: "Task completed", notifierValue: _taskCompleted),
            LabelledCheckbox(label: "Mentioned Me", notifierValue: _mentionedMe),
            LabelledCheckbox(label: "Direct Message", notifierValue: _directMessage),
          ]))))
    ]));
  }
}

class LabelledCheckbox extends StatelessWidget {
  final String label;
  final ValueNotifier<bool>? notifierValue;

  const LabelledCheckbox({
    required this.label,
    Key? key,
    this.notifierValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: GoogleFonts.lato(color: Colors.white, fontSize: 17)),
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.grey,
        ),
        child: ValueListenableBuilder(
            valueListenable: notifierValue!,
            builder: (BuildContext context, _, __) {
              return Checkbox(
                  value: notifierValue!.value,
                  activeColor: AppColors.primaryAccentColor,
                  onChanged: (bool? value) => notifierValue!.value = value!);
            }),
      ),
    ]);
  }
}
