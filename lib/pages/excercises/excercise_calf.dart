import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ExcerciseCalf extends StatefulWidget {
  const ExcerciseCalf({super.key});

  @override
  State<ExcerciseCalf> createState() => _ExcerciseCalfState();
}

class _ExcerciseCalfState extends State<ExcerciseCalf> {
  CountDownController contrl = CountDownController();
  String buttonName = 'Start';
  int duration = 10;
  IconData iconForButton = UniconsLine.forward;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excercising the calf')),
      body: Center(
        child: Column(children: [
          CircularCountDownTimer(
            duration: duration,
            initialDuration: 0,
            controller: contrl,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Colors.purpleAccent[100]!,
            fillGradient: null,
            backgroundColor: Colors.purple[500],
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: duration > 60
                ? CountdownTextFormat.MM_SS
                : CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {
              debugPrint('Countdown Started');
            },
            onComplete: () {
              debugPrint('Countdown Ended');
            },
            onChange: (String timeStamp) {
              debugPrint('Countdown Changed $timeStamp');
            },
            timeFormatterFunction: (defaultFormatterFunction, duration) {
              if (duration.inSeconds == 0) {
                return '';
              } else {
                return Function.apply(defaultFormatterFunction, [duration]);
              }
            },

            // CircularPercentIndicator(
            //   radius: 140,
            //   lineWidth: 20,
            //   percent: 0.1,
            //   progressColor: Colors.deepPurple,
            //   backgroundColor: Colors.purple.shade100,
            //   circularStrokeCap: CircularStrokeCap.round,
            // )
          ),
          ElevatedButton.icon(
              onPressed: () {
                if (contrl.isPaused) {
                  print('test');
                  setState(() {
                    iconForButton = UniconsLine.pause;
                    buttonName = "Pause";
                  });
                  contrl.resume();
                  return;
                }
                if (contrl.isStarted) {
                  contrl.pause();
                  setState(() {
                    iconForButton = UniconsLine.forward;
                    buttonName = "Continue";
                  });
                  return;
                }
                contrl.start();
                setState(() {
                  iconForButton = UniconsLine.pause;
                  buttonName = "Pause";
                });
              },
              icon: Icon(iconForButton),
              label: Text(buttonName)),
        ]),
      ),
    );
  }
}
