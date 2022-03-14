import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Screens/Auth/email_address.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:myey/components/widgets/Onboarding/image_outlined_button.dart';
import 'package:myey/components/widgets/Onboarding/slider_captioned_image.dart';

class OnboardingCarousel extends StatefulWidget {
  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isActive ? HexColor.fromHex("266FFE") : HexColor.fromHex("666A7A"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
                // height: double.infinity,
                // width: double.infinity,
                child: DarkRadialBackground(
                  color: HexColor.fromHex("#181a1f"),
                  position: "bottomRight",
                ),
              ),
              //Buttons positioned below
              Column(children: [
                Container(
                    height: Utils.screenHeight * 1.3,
                    child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          SliderCaptionedImage(
                              index: 0,
                              imageUrl: "assets/slider-background-1.png",
                              caption: "Now 🤩\nTest Eyes\nOn Phone"),
                          SliderCaptionedImage(
                              index: 1,
                              imageUrl: "assets/slider-background-3.png",
                              caption: "Compete 🥇\nGlobally\nWith Friends"),
                          SliderCaptionedImage(
                              index: 2,
                              imageUrl: "assets/slider-background-2.png",
                              caption: "Redeem 💰\nPoints\nOn Testing")
                        ])),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildPageIndicator(),
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => EmailAddressScreen());
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      HexColor.fromHex("76C4AE")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: HexColor.fromHex(
                                                  "76C4AE"))))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.email, color: Colors.white),
                                  Text('   Continue with Email',
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              )),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By continuing you agree myey_app\'s Terms of Services & Privacy Policy.',
                                style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: HexColor.fromHex("666A7A")),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '\n\nFor compaines can ',
                                    style: GoogleFonts.lato(
                                        fontSize: 15,
                                        color: HexColor.fromHex("666A7A")),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Login Here',
                                        style: GoogleFonts.lato(
                                            fontSize: 15,
                                            color: HexColor.fromHex("76C4AE"),
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                      ]),
                    ),
                  ),
                ),
              ])
            ])));
  }
}
