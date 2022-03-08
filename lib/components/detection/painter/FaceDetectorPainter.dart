// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../FaceDetector.dart';
import 'CoordinatesTranslator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;

    for (final Face face in faces) {
      void paintContour() {
        final pointsLeftEye =
            face.getContour(FaceContourType.leftEye)?.positionsList;
        final pointsRightEye =
            face.getContour(FaceContourType.rightEye)?.positionsList;

        if (pointsLeftEye != null && pointsRightEye != null) {
          final pointLeftEyeX = pointsLeftEye[8].dx;
          final pointLeftEyeY = pointsLeftEye[8].dy;

          final pointRightEyeX = pointsRightEye[0].dx;
          final pointRightEyeY = pointsRightEye[0].dy;

          final distance = sqrt((pow((pointLeftEyeX - pointRightEyeX), 2) +
              pow((pointLeftEyeY - pointRightEyeY), 2))).toInt();

          onDistance(distance);

          canvas.drawLine(
              Offset(
                  translateX(pointLeftEyeX, rotation, size, absoluteImageSize),
                  translateY(pointLeftEyeY, rotation, size, absoluteImageSize)),
              Offset(
                  translateX(pointRightEyeX, rotation, size, absoluteImageSize),
                  translateY(
                      pointRightEyeY, rotation, size, absoluteImageSize)),
              paint);
        }
      }

      paintContour();

    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
