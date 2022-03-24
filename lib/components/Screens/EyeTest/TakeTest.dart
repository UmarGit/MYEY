import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Screens/Dashboard/timeline.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Buttons/primary_buttons.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TakeTest extends StatefulWidget {
  const TakeTest({Key? key, required this.distance}) : super(key: key);

  final double distance;

  @override
  State<TakeTest> createState() => _TakeTestState();
}

class _TakeTestState extends State<TakeTest> {
  EyeTest test = EyeTest();
  double testingScore = 0;
  bool isStarted = false;
  bool isFinished = false;
  int mistakes = 0;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechInit = false;
  bool _speechEnabled = false;
  String guessStatus = '';
  String _recognizedWords = ' ';

  Future<void> _stopListening() async {
    await _speechToText.stop();
  }

  @override
  void initState() {
    _initSpeech().whenComplete(() => {
          setState(() {
            _speechInit = true;
          })
        });
    test.reset();
    super.initState();
  }

  @override
  void dispose() {
    test.reset();
    _stopListening();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onError: errorListener,
    );
  }

  void errorListener(SpeechRecognitionError error) {
    tryToGuess();
  }

  Future<void> _startListening() async {
    setState(() {
      guessStatus = 'Guessing...';
    });
    await _speechToText.listen(
        listenFor: const Duration(seconds: 60),
        pauseFor: const Duration(seconds: 10),
        partialResults: true,
        localeId: "en-PK",
        onResult: _onSpeechResult);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      setState(() {
        _recognizedWords = result.recognizedWords;
      });
      checkIfGuessed();
    }
  }

  void checkIfGuessed() {
    bool didGuessed =
        _recognizedWords[0].toLowerCase() == test.currentLetter().toLowerCase();

    setState(() {
      guessStatus = didGuessed ? 'You guessed correct' : 'You guessed wrong';
    });

    proceedToNextLevel(didGuessed ? LEVEL_STATUS.passed : LEVEL_STATUS.failed);

    tryToGuess();
  }

  void tryToGuess() {
    var counter = 4;
    Timer.periodic(const Duration(seconds: 2), (timer) {
      counter--;
      if (counter == 0) {
        _startListening();
        timer.cancel();
      }
      if (counter == 2) {
        setState(() {
          guessStatus = 'Starting next round...';
        });
      }
    });
  }

  void proceedToNextLevel(LEVEL_STATUS status) {
    // print(
    //     '\n\n\n\nMistakes $mistakes, Started $isStarted, Finished $isFinished, Status $status\n\n\n\n');

    if (status == LEVEL_STATUS.failed) {
      setState(() {
        mistakes = mistakes + 1;
      });
    }

    test.nextLetter(status);
  }

  void finishTesting() {
    setState(() {
      testingScore = test.getScore();
      isFinished = true;
      guessStatus = '';
    });
    _speechToText.cancel();
    test.reset();
  }

  void onClickHandler() {
    if (isStarted) {
      if (mistakes >= 2) {
        finishTesting();
      } else {
        proceedToNextLevel(LEVEL_STATUS.failed);
      }
    } else {
      setState(() {
        isStarted = true;
      });
      _startListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentLetter = test.currentLetter();
    double currentFontSize = test.currentFontSize();
    int currentLevel = test.currentLevel.index + 1;

    return Container(
      decoration: BoxDecorationStyles.fadingInnerDecor,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecorationStyles.fadingGlory,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: DecoratedBox(
                        decoration: BoxDecorationStyles.fadingInnerDecor,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Text(
                                'LEVEL $currentLevel' +
                                    (isFinished
                                        ? ' - Score $testingScore'
                                        : ''),
                                style: GoogleFonts.courierPrime(
                                    color: Colors.white),
                              )),
                              AppSpaces.verticalSpace10,
                              Container(
                                width: Utils.screenWidth,
                                height: Utils.screenHeight,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF262A34),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: isStarted
                                        ? isFinished
                                            ? Text(
                                                "Your Score is $testingScore",
                                                style:
                                                    GoogleFonts.courierPrime(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              )
                                            : Text(
                                                currentLetter,
                                                style:
                                                    GoogleFonts.courierPrime(
                                                        color: Colors.white,
                                                        fontSize:
                                                            currentFontSize),
                                                textAlign: TextAlign.center,
                                              )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                Text(
                                                  "INSTRUCTIONS 📜",
                                                  style: GoogleFonts
                                                      .courierPrime(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                  textAlign: TextAlign.center,
                                                ),
                                                AppSpaces.verticalSpace20,
                                                Text(
                                                  "1- Keep your focus on the screen and press 'Start Test' when ready !",
                                                  style: GoogleFonts
                                                      .courierPrime(
                                                          color:
                                                              Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                                AppSpaces.verticalSpace20,
                                                Text(
                                                  "2- Say the word that starts with the alphabet you see on the screen",
                                                  style: GoogleFonts
                                                      .courierPrime(
                                                          color:
                                                              Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                                AppSpaces.verticalSpace20,
                                                Text(
                                                  "3- You can make two mistakes only, otherwise the game will end",
                                                  style: GoogleFonts
                                                      .courierPrime(
                                                          color:
                                                              Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                                AppSpaces.verticalSpace20,
                                                Text(
                                                  "- GoodLuck -",
                                                  style: GoogleFonts
                                                      .courierPrime(
                                                          color:
                                                              Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ])),
                              ),
                              AppSpaces.verticalSpace20,
                              Center(
                                child: Text(
                                  guessStatus,
                                  style: GoogleFonts.courierPrime(
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              AppSpaces.verticalSpace20,
                              Center(
                                child: Column(
                                  children: [
                                    AppPrimaryButton(
                                      buttonHeight: 50,
                                      buttonWidth: 240,
                                      buttonText: isFinished
                                          ? "Continue To Leaderboard"
                                          : isStarted
                                              ? 'Skip Level $_recognizedWords'
                                              : "Begin Test",
                                      callback: () {
                                        if (isFinished) {
                                          Get.to(() => Timeline(
                                                selectedIndex: ValueNotifier(3),
                                              ));
                                        } else {
                                          onClickHandler();
                                        }
                                      },
                                    ),
                                    AppSpaces.verticalSpace10,
                                    !isFinished
                                        ? AppPrimaryButton(
                                            buttonHeight: 50,
                                            buttonWidth: 240,
                                            buttonText: "Finish Test",
                                            callback: () {
                                              _speechToText.cancel();
                                              finishTesting();
                                            },
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
