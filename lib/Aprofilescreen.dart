import 'package:flutter/material.dart';
import 'package:sapucar/Aloginscreen.dart';
import 'package:sapucar/model/admin.dart';

class AProfileScreen extends StatefulWidget {
  final Admin admin;
  const AProfileScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<AProfileScreen> createState() => _AProfileScreenState();
}

class _AProfileScreenState extends State<AProfileScreen> {
  late double screenHeight, screenWidth, resWidth;
  String titlecenter = "Profile";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
            child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Profile",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 15),
              Image.asset('assets/images/admin.jpg', width: 190),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(6),
                        },
                        border: const TableBorder(
                            verticalInside: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid)),
                        children: [
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "                  " +
                                    "                  " +
                                    "Email ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                " : " + widget.admin.email.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(height: 50),
                  SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text("Logout"),
                              onPressed: () {
                                _logout(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red))),
              const SizedBox(height: 230),
            ],
          ),
        )));
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
                    MaterialPageRoute(builder: (_) => const ALoginScreen()));
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
