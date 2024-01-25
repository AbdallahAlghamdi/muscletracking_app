import 'package:flutter/material.dart';
import 'package:muscletracking_app/front_page.dart';
import 'package:muscletracking_app/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muscle Tracking App',
      initialRoute: '/',
      routes: {
        '/frontPage': (context) => const FrontPage(),
        '/loginPage': (context) => const WelcomePage()
      },
      home: const WelcomePage(),
    );
  }
}
