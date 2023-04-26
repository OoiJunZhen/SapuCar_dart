import 'package:flutter/material.dart';
import 'package:sapucar/Pbookingscreen.dart';
import 'package:sapucar/Pdriverscreen.dart';
import 'package:sapucar/Pprofilescreen.dart';
import 'package:sapucar/model/passenger.dart';

class PMainScreen extends StatefulWidget {
  final Passenger passenger;
  const PMainScreen({Key? key, required this.passenger}) : super(key: key);

  @override
  State<PMainScreen> createState() => _PMainScreenState();
}

class _PMainScreenState extends State<PMainScreen> {
  late double screenHeight, screenWidth, ctrwidth, resWidth;
  late List<Widget> tabchildren;
  int currentIndex = 0;
  String maintitle = "Driver";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      PDriverScreen(
        passenger: widget.passenger,
      ),
      PBookingScreen(passenger: widget.passenger),
      // PDriverScreen(passenger: widget.passenger),
      PProfileScreen(passenger: widget.passenger),
    ];
  }

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
      body: tabchildren[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_taxi,
            ),
            label: "Driver",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
            ),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) {
        maintitle = "Driver";
      }
      if (currentIndex == 1) {
        maintitle = "Booking";
      }
      if (currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }

}