part of values;

class Utils {
  static final double screenWidth = Get.width;
  static final double screenHeight = Get.width;
}

class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 3});

  // t = x
  @override
  double transformInternal(double t) {
    var val = sin(count * 2 * pi * t) * 0.5 + 0.5;
    return val; //f(x)
  }
}

Widget buildStackedImages(
    {TextDirection direction = TextDirection.rtl,
    String? numberOfMembers,
    bool? addMore}) {
  final double size = 50;
  final double xShift = 20;

  Container lastContainer = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Center(
        child: Text(numberOfMembers!,
            style: GoogleFonts.lato(
                color: HexColor.fromHex("226AFD"),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ));

  Container iconContainer = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.primaryAccentColor, shape: BoxShape.circle),
      child: Icon(Icons.add, color: Colors.white));

  final items = List.generate(
      4,
      (index) => ProfileDummy(
          color: AppData.groupBackgroundColors[index],
          dummyType: ProfileDummyType.Image,
          image: AppData.profileImages[index],
          scale: 1.0));

  return StackedWidgets(
    direction: direction,
    items: [
      ...items,
      lastContainer,
      (addMore != null) ? iconContainer : SizedBox()
    ],
    size: size,
    xShift: xShift,
  );
}

enum LEVELS {
  level_1,
  level_2,
  level_3,
  level_4,
  level_5,
  level_6,
  level_7,
  level_8,
  level_9,
  level_10,
  level_11,
}

enum LEVEL_STATUS {
  passed,
  failed,
}

class EyeTest {
  late double score;
  late LEVELS currentLevel;
  late int currentIndex;
  late Map<LEVELS, List<String>> levels;
  late Map<LEVELS, double> points;
  late Map<LEVELS, double> fontSizes;
  Map<LEVELS, List<LEVEL_STATUS>> levelsStatus = {};

  EyeTest() {
    reset();
  }

  void reset() {
    score = 0;

    levels = {
      LEVELS.level_1: ['E'],
      LEVELS.level_2: ['F', 'P'],
      LEVELS.level_3: ['T', 'O', 'Z'],
      LEVELS.level_4: ['L', 'P', 'E', 'D'],
      LEVELS.level_5: ['P', 'E', 'C', 'F', 'D'],
      LEVELS.level_6: ['E', 'D', 'F', 'C', 'Z', 'P'],
      LEVELS.level_7: ['F', 'E', 'L', 'O', 'P', 'Z', 'D'],
      LEVELS.level_8: ['D', 'E', 'F', 'P', 'O', 'T', 'E', 'C'],
      LEVELS.level_9: ['L', 'E', 'F', 'O', 'D', 'P', 'C', 'T'],
      LEVELS.level_10: ['F', 'D', 'P', 'L', 'T', 'C', 'E', 'O'],
    };

    levelsStatus = {
      LEVELS.level_1: [LEVEL_STATUS.failed],
      LEVELS.level_2: [LEVEL_STATUS.failed, LEVEL_STATUS.failed],
      LEVELS.level_3: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_4: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_5: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_6: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_7: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_8: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_9: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
      LEVELS.level_10: [
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed,
        LEVEL_STATUS.failed
      ],
    };

    points = {
      LEVELS.level_1: 70,
      LEVELS.level_2: 60,
      LEVELS.level_3: 50,
      LEVELS.level_4: 40,
      LEVELS.level_5: 30,
      LEVELS.level_6: 20,
      LEVELS.level_7: 15,
      LEVELS.level_8: 10,
      LEVELS.level_9: 7,
      LEVELS.level_10: 4,
    };

    fontSizes = {
      LEVELS.level_1: 152,
      LEVELS.level_2: 130,
      LEVELS.level_3: 108,
      LEVELS.level_4: 87,
      LEVELS.level_5: 65,
      LEVELS.level_6: 43,
      LEVELS.level_7: 33,
      LEVELS.level_8: 21,
      LEVELS.level_9: 15,
      LEVELS.level_10: 9,
    };

    currentLevel = LEVELS.level_1;
    currentIndex = 0;
  }

  String currentLetter() {
    List<String>? letters = levels[currentLevel];

    return letters![currentIndex];
  }

  double currentFontSize() {
    double? fontSize = fontSizes[currentLevel];

    return fontSize! / 10;
  }

  void nextLetter(LEVEL_STATUS status) {
    List<String>? letters = levels[currentLevel];
    List<LEVEL_STATUS>? statuses = levelsStatus[currentLevel];
    int lettersLength = letters!.length;

    statuses![currentIndex] = status;

    if ((lettersLength - 1) == currentIndex) {
      int levelsLimit = LEVELS.values.length;

      if ((levelsLimit - 1) != currentLevel.index) {
        if (currentLevel.index + 1 != levels.length) {
          currentIndex = 0;
          currentLevel = LEVELS.values
              .where((e) => e.index == currentLevel.index + 1)
              .first;
        } else {
          // print('Finish');
        }
      }
    } else {
      currentIndex = currentIndex + 1;
    }
  }

  double getScore() {
    List<LEVEL_STATUS>? statuses = levelsStatus[currentLevel];
    int penalty = 0;
    double finalScore = 0;

    for (var element in statuses!) {
      if (element == LEVEL_STATUS.failed) {
        penalty = penalty + 1;
      }
    }

    if (penalty >= 2) {
      if (currentLevel.index != 0) {
        currentLevel =
            LEVELS.values.where((e) => e.index == currentLevel.index - 1).first;
      }
    }
    // print(points[currentLevel].toString() + ' ' + penalty.toString());
    finalScore = points[currentLevel]! / 20 - penalty;

    return finalScore;
  }
}
