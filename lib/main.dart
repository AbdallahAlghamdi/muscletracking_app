import 'package:flutter/material.dart';
import 'package:muscletracking_app/front_page.dart';
import 'package:muscletracking_app/pages/login/sign_up_page.dart';
import 'package:muscletracking_app/pages/login/successful_registration.dart';
import 'package:muscletracking_app/pages/login/welcome_page.dart';

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
        '/loginPage': (context) => const WelcomePage(),
        '/signupPage': (context) => const SignUpPage(),
        '/sucreg': (context) => const SuccessfulRegistration(),
      },
      home: const WelcomePage(),
    );
  }
}
