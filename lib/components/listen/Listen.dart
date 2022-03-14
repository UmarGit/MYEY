// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:math';

class Listen extends StatefulWidget {
  const Listen({Key? key}) : super(key: key);

  @override
  _ListenState createState() => _ListenState();
}

class _ListenState extends State<Listen> {
  bool _firstStart = true;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = ' ';
  String _randomAlphabet = '';

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

  /// Each time to start a speech recognition session
  void _startListening() async {
    _firstStart = false;
    setState(() {
      _randomAlphabet = generateRandomString();
    });
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: _firstStart
          ? const Center(
              child: Text("Tap Microphone To Start"),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Name something from this alphabet:',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  _randomAlphabet,
                                  style: const TextStyle(
                                      fontSize: 180.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_lastWords),
                            Text(
                              // If listening is active show the recognized words
                              !_speechToText.isListening
                                  ? (_lastWords.isNotEmpty
                                          ? _lastWords[0]
                                          : 'UNDEF') +
                                      ' = ' +
                                      _randomAlphabet +
                                      ' => ' +
                                      'Validating results: ' +
                                      ((_lastWords.isNotEmpty
                                                      ? _lastWords[0]
                                                      : 'UNDEF')
                                                  .toUpperCase() ==
                                              _randomAlphabet)
                                          .toString()
                                  // If listening isn't active but could be tell the user
                                  // how to start it, otherwise indicate that speech
                                  // recognition is not yet ready or not supported on
                                  // the target device
                                  : _speechEnabled
                                      ? 'listening...'
                                      : 'Speech not available',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic : Icons.hearing),
      ),
    );
  }
}
