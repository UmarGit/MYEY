import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/dummy/profile_dummy.dart';

class DashboardNav extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onImageTapped;
  final String notificationCount;

  DashboardNav(
      {Key? key,
      required this.title,
      required this.icon,
      required this.notificationCount,
      this.onImageTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(this.title, style: AppTextStyles.header2),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        InkWell(
          onTap: onImageTapped,
          child: Stack(children: <Widget>[
            Icon(icon, color: Colors.white, size: 30),
          ]),
        ),
      ])
    ]);
  }
}
