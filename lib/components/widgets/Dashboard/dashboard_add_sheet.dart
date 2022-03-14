import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myey/components/BottomSheets/bottom_sheets.dart';
import 'package:myey/components/Screens/Projects/create_project.dart';
import 'package:myey/components/Screens/Projects/set_members.dart';
import 'package:myey/components/Screens/Scanning/ScanGuide.dart';
import 'package:myey/components/Screens/Task/task_due_date.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/BottomSheets/bottom_sheet_holder.dart';
import 'package:myey/components/widgets/Onboarding/labelled_option.dart';

import 'create_task.dart';

class DashboardAddBottomSheet extends StatelessWidget {
  const DashboardAddBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppSpaces.verticalSpace10,
      BottomSheetHolder(),
      AppSpaces.verticalSpace10,
      LabelledOption(
        label: 'Start Scanning',
        icon: Icons.account_box_outlined,
        callback: () {
          Get.to(() => ScanGuide());
        }
      ),
      // LabelledOption(
      //     label: 'Create Project',
      //     icon: Icons.device_hub,
      //     callback: () {
      //       Get.to(() => CreateProjectScreen());
      //     }),
      // LabelledOption(
      //     label: 'Create team',
      //     icon: Icons.people,
      //     callback: () {
      //       Get.to(() => SelectMembersScreen());
      //     }),
      // LabelledOption(
      //     label: 'Create Event',
      //     icon: Icons.fiber_smart_record,
      //     callback: () {
      //       Get.to(() => TaskDueDate());
      //     }),
    ]);
  }

  void _createTask() {
    showAppBottomSheet(
      CreateTaskBottomSheet(),
      isScrollControlled: true,
      popAndShow: true,
    );
  }
}
