import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';
import 'package:muscletracking_app/pages/login/welcome_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  initState() {
    super.initState();
  }

  final List<bool> selectedOption = <bool>[false, false];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  )),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
              child: const Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertPopUp(
                          text: "This app connects to an EMG sensor. But the"
                              "data it recieves do not correlate with any real"
                              "life metrics. The sensor can assign a value to an"
                              "activity exhibited by the muscle, and an increase"
                              "in percieved acivity correlates to increased muscle"
                              "mass.",
                          icon: Icon(Icons.info));
                    });
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}
