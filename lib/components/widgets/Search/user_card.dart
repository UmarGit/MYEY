import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Onboarding/background_image.dart';
import 'package:myey/components/widgets/dummy/green_done_icon.dart';

class UserCard extends StatefulWidget {
  const UserCard(
      {Key? key,
      required this.header,
      required this.subHeader,
      required this.date,
      required this.score})
      : super(key: key);

  final String header;
  final String subHeader;
  final String date;
  final String score;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: AppColors.primaryBackgroundColor, width: 4),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryBackgroundColor,
                      ),
                      child: const GreenDoneIcon()),
                  AppSpaces.horizontalSpace20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.header,
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          widget.subHeader,
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 10),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.subHeader == "Platinum"
                                ? Colors.grey
                                : widget.subHeader == "Gold"
                                    ? Colors.orange
                                    : widget.subHeader == "Bronze"
                                        ? Colors.brown
                                        : widget.subHeader == "Silver"
                                            ? Colors.blueGrey
                                            : Colors.green),
                      ),
                      Text(
                        widget.date,
                        style: GoogleFonts.lato(
                          color: HexColor.fromHex("5A5E6D"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.score,
                    style: GoogleFonts.lato(
                        color: Colors.green, fontWeight: FontWeight.w900),
                  ),
                  AppSpaces.horizontalSpace10,
                  BackgroundImage(
                    scale: 0.15,
                    image: "assets/icon/logo.png",
                    gradient: [
                      HexColor.fromHex("ffffff").withOpacity(0),
                      HexColor.fromHex("ffffff").withOpacity(0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpaces.verticalSpace10,
      ],
    );
  }
}
