import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sapucar/Ploginscreen.dart';
import 'package:sapucar/constants.dart';
import 'package:sapucar/model/passenger.dart';

class PProfileScreen extends StatefulWidget {
  final Passenger passenger;
  const PProfileScreen({Key? key, required this.passenger}) : super(key: key);

  @override
  State<PProfileScreen> createState() => _PProfileScreenState();
}

class _PProfileScreenState extends State<PProfileScreen> {
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
              CachedNetworkImage(
                imageUrl: CONSTANTS.server +
                    "/SapuCar/mobile/assets/Pimages/" +
                    widget.passenger.id.toString() +
                    '.jpg',
                fit: BoxFit.cover,
                width: 175,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(5),
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
                                    "Name ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                " : " + widget.passenger.name.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ]),
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
                                " : " + widget.passenger.email.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "                  " +
                                    "                  " +
                                    "Phone No. ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                " : " + widget.passenger.phone.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "                  " +
                                    "                  " +
                                    "Matric/Staff No. ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                " : " +
                                    widget.passenger.matricStaffNo.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            const TableCell(
                              child: Text(
                                "                  " +
                                    "                  " +
                                    "Gender ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                " : " + widget.passenger.gender.toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 250),
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
                    MaterialPageRoute(builder: (_) => const PLoginScreen()));
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
