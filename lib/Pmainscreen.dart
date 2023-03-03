import 'package:flutter/material.dart';
import 'package:sapucar/Pbookingscreen.dart';
import 'package:sapucar/Pdriverscreen.dart';
import 'package:sapucar/Ploginscreen.dart';
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
      PDriverScreen(passenger: widget.passenger),
    ];
  }

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
              Icons.person,
            ),
            label: "Driver",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
            ),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout_rounded,
            ),
            label: "Logout",
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
        _logout(context);
      }
    });
  }

  void _logout(BuildContext context) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Log Out ",
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const PLoginScreen()));
                //Navigator.of(context).pop();
                // _logout();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}