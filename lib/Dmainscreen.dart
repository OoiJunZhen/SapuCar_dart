import 'package:flutter/material.dart';
import 'package:sapucar/Dprofilescreen.dart';
import 'package:sapucar/Dpassengerscreen.dart';
import 'package:sapucar/model/driver.dart';

class DMainScreen extends StatefulWidget {
  final Driver driver;
  const DMainScreen({Key? key, required this.driver}) : super(key: key);

  @override
  State<DMainScreen> createState() => _DMainScreenState();
}

class _DMainScreenState extends State<DMainScreen> {
  late double screenHeight, screenWidth, ctrwidth, resWidth;
  late List<Widget> tabchildren;
  int currentIndex = 0;
  String maintitle = "Passenger Bookings";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      DPassengerBookingScreen(
        driver: widget.driver,
      ),
     DProfileScreen(driver: widget.driver),
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
              Icons.calendar_month,
            ),
            label: "Passenger Bookings",
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
        maintitle = "Passenger Bookings";
      }
      if (currentIndex == 1) {
        maintitle = "Profile";
      }
    });
  }

  // void _logout(BuildContext context) {
    
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: const Text(
  //           "Log Out ",
  //         ),
  //         content: const Text(
  //           "Are you sure?",
  //           style: TextStyle(),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text(
  //               "Yes",
  //               style: TextStyle(),
  //             ),
  //             onPressed: () {
  //               Navigator.canPop(context) ? Navigator.pop(context) : null;
  //               Navigator.pushReplacement(context,
  //                   MaterialPageRoute(builder: (_) => const DLoginScreen()));
  //               //Navigator.of(context).pop();
  //               // _logout();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text(
  //               "No",
  //               style: TextStyle(),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}