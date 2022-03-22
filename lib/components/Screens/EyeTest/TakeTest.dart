import 'dart:async';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Values/values.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TakeTest extends StatefulWidget {
  const TakeTest({Key? key, required this.distance}) : super(key: key);

  final double distance;

  @override
  State<TakeTest> createState() => _TakeTestState();
}

class _TakeTestState extends State<TakeTest> {
  int count = 0;
  bool _firsStart= true;
  Set<double> fontSizes = {15.2, 13, 10.8, 8.7, 6.5, 4.3};
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = ' ';
  String _randomAlphabet = '';
  late Timer timer;
  Duration timeInBetweenRounds = const Duration(seconds: 15);
  int timeLeft = 15;
  void _startTimer() {
    /// timer for every 15 second of the round
    // Timer timer =
    _firsStart?_startListening():null;
    Timer.periodic(timeInBetweenRounds, (timer) {
      if (_speechToText.isNotListening && count < fontSizes.length) {
        _startListening();
      } else {
        _stopListening();
      }
      if (count < fontSizes.length) {
        setState(() {
          count++;
        });
      } else {
        timer.cancel();
      }
    });

    ///timer for every second of the round
    // Timer tim =
    Timer.periodic(const Duration(seconds: 1), (tim) {
      if (timeLeft == 0) {
        setState(() {
          timeLeft = 15;
        });
      }
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        tim.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
    setState(() {
      _randomAlphabet = generateRandomString();
    });
  }

  String generateRandomString([int len = 1]) {
    var r = Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void _startListening() async {
    setState(() {
      _randomAlphabet = generateRandomString();
    });
    await _speechToText.listen(
      onResult: _onSpeechResult,listenFor: timeInBetweenRounds
    );
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _randomAlphabet = generateRandomString();
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    // todo use in range to start the quiz
    // bool inRange =
    //     ((widget.distance / 30.48) >= 1.9 && (widget.distance / 30.48) <= 2.1
    //         ? true
    //         : false);

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
                            child: count < fontSizes.length
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      // child:Text(''+inRange.toString()),
                                      // child: eyeTest(
                                      //   widget.distance,
                                      // ),
                                      // child:
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Name something from this alphabet:',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            _randomAlphabet,
                                            style: GoogleFonts.courierPrime(
                                                fontSize:
                                                    fontSizes.elementAt(count),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      // ),
                                      Text(
                                          !_speechToText.isListening
                                              ? (_lastWords.isNotEmpty
                                                      ? _lastWords[0]
                                                      : 'UNDEF') +
                                                  ' = ' +
                                                  _randomAlphabet +
                                                  ' => ' +
                                                  'Validating results: ' +
                                                  ((_lastWords.isNotEmpty
                                                                  ? _lastWords[
                                                                      0]
                                                                  : 'UNDEF')
                                                              .toUpperCase() ==
                                                          _randomAlphabet)
                                                      .toString()
                                              : _speechEnabled
                                                  ? 'listening...'
                                                  : 'Speech not available',
                                          style:
                                              const TextStyle(color: Colors.white)),
                                      // ElevatedButton(
                                      //   onPressed: _speechToText.isNotListening
                                      //       ? _startListening
                                      //       : _stopListening,
                                      //   child: Icon(_speechToText.isNotListening
                                      //       ? Icons.mic
                                      //       : Icons.hearing),
                                      // ),
                                      Text(timeLeft.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      AvatarGlow(
                                        animate: _speechToText.isListening,
                                        glowColor:
                                            Theme.of(context).primaryColor,
                                        endRadius: 75,
                                        child: ElevatedButton(
                                            onPressed: _startTimer,
                                            child: const Icon(
                                              Icons.mic,
                                            )),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    "test completed",
                                    style: TextStyle(color: Colors.white),
                                  )),
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

  //here distance is in cm
  Widget eyeTest(double distance) {
    int count = 0;
    Set<double> fontSizes = {15.2, 13, 10.8, 8.7, 6.5, 4.3};
    const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int ranIndex = Random().nextInt(letters.length);
    return Text(
      letters[ranIndex],
      style: GoogleFonts.courierPrime(
          fontWeight: FontWeight.bold,
          fontSize: fontSizes.elementAt(count),
          color: Colors.white),
    );
  }
}
