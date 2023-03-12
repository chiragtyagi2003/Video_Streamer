import 'package:blackcoffer/SignUp.dart';
import 'package:blackcoffer/home.dart';
import 'package:blackcoffer/otp_verification.dart';
import 'package:blackcoffer/playVideo.dart';
import 'package:blackcoffer/showVideos.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'signup',
      //home: SignUp(),
      debugShowCheckedModeBanner: false,
      routes: {
        'signup': (context) => SignUp(),
        'otp': (context) => OTP_verification(),
        'home': (context) => Home(),
        'play': (context) => VideoPlayerScreen(),
        'show': (context) => showVideos(),

      },
    );
  }
}