import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sapucar/charscreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SapuCar',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MyTutorSplashScreen(title: 'SapuCar'),
    );
  }
}

class MyTutorSplashScreen extends StatefulWidget {
  const MyTutorSplashScreen({Key? key, required String title})
      : super(key: key);

  @override
  State<MyTutorSplashScreen> createState() => _MyTutorSplashScreenState();
}

class _MyTutorSplashScreenState extends State<MyTutorSplashScreen> {
  late double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => const SCCharScreen())));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/lightGreen_bg.jpg"),
                      fit: BoxFit.cover))),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: Image.asset('assets/images/UUMGO SC.png'),
              ),
              const Text("Version 1.0",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
