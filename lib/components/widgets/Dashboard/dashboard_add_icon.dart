import 'package:flutter/material.dart';
import 'package:myey/components/Values/values.dart';

class DashboardAddButton extends StatelessWidget {
  final VoidCallback? iconTapped;
  const DashboardAddButton({
    Key? key,
    this.iconTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: iconTapped,
      child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: AppColors.primaryAccentColor, shape: BoxShape.circle),
          child: Icon(Icons.camera_front_outlined, color: Colors.white)),
    );
  }
}
