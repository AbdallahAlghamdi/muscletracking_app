import 'package:muscletracking_app/pages/excercise_page.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/pages/report_page.dart';
import 'package:muscletracking_app/pages/settings_page.dart';
import 'package:muscletracking_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  void changePage(int value) {
    setState(() {
      currentPage = pages[value];
      currentIndexBottomBar = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final pages = const [ReportPage(), ExcercisePage(), SettingsPage()];
  int currentIndexBottomBar = 1;
  Widget currentPage = const ExcercisePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: currentPage),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndexBottomBar,
          items: [
            BottomNavigationBarItem(
                label: 'Report',
                icon: Icon(
                  UniconsLine.chart,
                  color: primaryColor,
                )),
            BottomNavigationBarItem(
                label: 'Exercise',
                icon: Icon(
                  UniconsLine.dumbbell,
                  color: primaryColor,
                )),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(
                  UniconsLine.setting,
                  color: primaryColor,
                )),
          ],
          onTap: changePage,
          selectedItemColor: primaryColorSelected,
        ));
  }
}
