import 'package:flutter/material.dart';
import 'package:sapucar/Adriverappscreen.dart';
import 'package:sapucar/Aloginscreen.dart';
import 'package:sapucar/Aprofilescreen.dart';
import 'package:sapucar/model/admin.dart';

class AMainScreen extends StatefulWidget {
  final Admin admin;
  const AMainScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<AMainScreen> createState() => _AMainScreenState();
}

class _AMainScreenState extends State<AMainScreen> {
  late double screenHeight, screenWidth, ctrwidth, resWidth;
  late List<Widget> tabchildren;
  int currentIndex = 0;
  String maintitle = "Driver Application";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      ADriverAppScreen(
        admin: widget.admin,
      ),
      // ADriverAppScreen(admin: widget.admin),
     AProfileScreen(admin: widget.admin),
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
              Icons.menu_book_outlined,
            ),
            label: "Driver Application",
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
        maintitle = "Driver Application";
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
  //                   MaterialPageRoute(builder: (_) => const ALoginScreen()));
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
