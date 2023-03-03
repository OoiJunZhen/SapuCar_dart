import 'package:flutter/material.dart';
import 'package:sapucar/Ploginscreen.dart';
import 'package:sapucar/Dloginscreen.dart';
import 'package:sapucar/Aloginscreen.dart';



class SCCharScreen extends StatefulWidget {
  const SCCharScreen({Key? key}) : super(key: key);

  @override
  State<SCCharScreen> createState() => _SCCharScreenState();
}

class _SCCharScreenState extends State<SCCharScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: ctrwidth,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: screenHeight / 2.5,
                              width: screenWidth,
                              child: Image.asset(
                                  'assets/images/UUMGO SC.png')),
                          const Text(
                            "I'm:",
                            style: TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _passengerScreen,
                                  child: const Text("Passenger"),
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _driverScreen,
                                  child: const Text("Driver"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                    width: 100,
                                  ),
                                  SizedBox(
                            width: 130,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _adminScreen,
                              child: const Text("Admin"),
                            ),
                          ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _passengerScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (content) => const PLoginScreen()));
  }

  void _driverScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (content) => const DLoginScreen()));
  }

  void _adminScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (content) => const ALoginScreen()));
  }


}
