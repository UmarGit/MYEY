import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/BottomSheets/project_detail_sheet.dart';

class myey_appBottomSheet {
  // static const MethodChannel _channel = MethodChannel('myey_appBottomSheet');
}

showSettingsBottomSheet() => showAppBottomSheet(ProjectDetailBottomSheet());

showAppBottomSheet(Widget widget, {bool isScrollControlled = false, bool popAndShow = false, double? height}) {
  if (popAndShow) Get.back();
  return Get.bottomSheet(height == null ? widget : Container(height: height, child: widget),
      backgroundColor: AppColors.primaryBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: isScrollControlled);
}
