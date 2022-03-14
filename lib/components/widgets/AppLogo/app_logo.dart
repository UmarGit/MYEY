import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Opacity(
          child: SvgPicture.asset('assets/icon/logo.svg',
              semanticsLabel: 'Myey Logo'),
          opacity: 0.7,
        ),
      ),
    );
  }
}
