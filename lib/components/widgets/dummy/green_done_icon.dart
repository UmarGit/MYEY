import 'package:flutter/material.dart';
import 'package:myey/components/Values/values.dart';

class GreenDoneIcon extends StatelessWidget {
  const GreenDoneIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: HexColor.fromHex("78B462")),
          child: Icon(Icons.person_rounded, color: Colors.white)),
    );
  }
}
