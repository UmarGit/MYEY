import 'package:flutter/material.dart';
import 'package:myey/components/Values/values.dart';

class TakeTest extends StatefulWidget {
  const TakeTest({Key? key, required this.distance}) : super(key: key);

  final double distance;

  @override
  State<TakeTest> createState() => _TakeTestState();
}

class _TakeTestState extends State<TakeTest> {
  @override
  Widget build(BuildContext context) {
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
                              Container(
                                child: const Text('Hello world'),
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
