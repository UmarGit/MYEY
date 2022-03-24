import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myey/components/Values/values.dart';
import 'package:myey/components/widgets/Buttons/primary_tab_buttons.dart';
import 'package:myey/components/widgets/Forms/search_box.dart';
import 'package:myey/components/widgets/Search/user_card.dart';
import 'package:myey/components/widgets/dummy/green_done_icon.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<int> _settingsButtonTrigger = ValueNotifier(0);

  final players = [
    {
      "header": 'Umar Ahmed',
      "subHeader": 'Gold',
      "date": '21 May, 2022',
      "score": '1200'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: SearchBox(
                        placeholder: 'Search...',
                        controller: _searchController),
                  ),
                ),
              ],
            ),
            AppSpaces.verticalSpace10,
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //tab indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrimaryTabButton(
                      buttonText: "Global",
                      itemIndex: 0,
                      notifier: _settingsButtonTrigger),
                  PrimaryTabButton(
                      buttonText: "National",
                      itemIndex: 1,
                      notifier: _settingsButtonTrigger),
                  PrimaryTabButton(
                      buttonText: "Local",
                      itemIndex: 2,
                      notifier: _settingsButtonTrigger),
                ],
              ),
            ]),
            AppSpaces.verticalSpace20,
            Expanded(
              child: ListView(
                children: const [
                  UserCard(
                    header: 'Umar Ahmed',
                    subHeader: 'Gold',
                    date: '21 May, 2022',
                    score: '1200',
                  ),
                  UserCard(
                    header: 'Subhan Talal',
                    subHeader: 'Bronze',
                    date: '22 May, 2022',
                    score: '400',
                  ),
                  UserCard(
                    header: 'Subhan Ahmed',
                    subHeader: 'Silver',
                    date: '16 Apr, 2022',
                    score: '300',
                  ),
                  UserCard(
                    header: 'Umer Waseem',
                    subHeader: 'Platinum',
                    date: '21 Aug, 2022',
                    score: '280',
                  ),
                  UserCard(
                    header: 'Mutahar Jamal',
                    subHeader: 'Gold',
                    date: '01 Dec, 2022',
                    score: '256',
                  ),
                  UserCard(
                    header: 'Bushra Tariq',
                    subHeader: 'Gold',
                    date: '13 Jun, 2022',
                    score: '126',
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
