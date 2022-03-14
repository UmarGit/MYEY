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
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (final Face face in faces) {
      void paintContour() {
        final pointsLeftEye =
            face.getContour(FaceContourType.leftEye)?.positionsList;
        final pointsRightEye =
            face.getContour(FaceContourType.rightEye)?.positionsList;
        final pointsFace = face.getContour(FaceContourType.face)?.positionsList;
        final pointsNose =
            face.getContour(FaceContourType.noseBridge)?.positionsList;

        if (pointsLeftEye != null &&
            pointsRightEye != null &&
            pointsFace != null &&
            pointsNose != null) {

          final coordinatesAxis = [
            [
              pointsLeftEye[8].dx,
              pointsLeftEye[8].dy,
              pointsRightEye[0].dx,
              pointsRightEye[0].dy
            ],
            [
              pointsFace[0].dx,
              pointsFace[0].dy,
              pointsFace[18].dx,
              pointsFace[18].dy
            ],
            [
              pointsFace[27].dx,
              pointsFace[27].dy,
              pointsFace[9].dx,
              pointsFace[9].dy
            ],
          ];

          List<int> distances = [];

          for (List<double> coordinate in coordinatesAxis) {
            canvas.drawLine(
                Offset(
                    translateX(
                        coordinate[0], rotation, size, absoluteImageSize),
                    translateY(
                        coordinate[1], rotation, size, absoluteImageSize)),
                Offset(
                    translateX(
                        coordinate[2], rotation, size, absoluteImageSize),
                    translateY(
                        coordinate[3], rotation, size, absoluteImageSize)),
                paint);

            distances.add(sqrt((pow((coordinate[0] - coordinate[2]), 2) +
                    pow((coordinate[1] - coordinate[3]), 2)))
                .toInt());
          }

          distances.add(pointsNose[1].dy.toInt());

          onDistances(distances);
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
