import 'package:flutter/material.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Dashboard/daily_goal_card.dart';
import 'package:myey/components/widgets/Dashboard/productivity_chart.dart';

class DashboardProductivity extends StatelessWidget {
  const DashboardProductivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DailyGoalCard(),
        AppSpaces.verticalSpace20,
        ProductivityChart()
      ],
    );
  }
}
