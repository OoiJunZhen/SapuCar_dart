import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:sapucar/model/driver.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sapucar/model/passenger.dart';

class PDriverScreen extends StatefulWidget {
  final Passenger passenger;
  const PDriverScreen({Key? key, required this.passenger}) : super(key: key);

  @override
  State<PDriverScreen> createState() => _PDriverScreenState();
}

class _PDriverScreenState extends State<PDriverScreen> {
  late double screenHeight, screenWidth, resWidth;
  var numofpage, curpage = 1;
  int currentIndex = 0;
  List<Driver> driverList = <Driver>[];
  String search = "";
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController noPassCtrl = TextEditingController();
  TextEditingController pickUpCtrl = TextEditingController();
  TextEditingController dropOffCtrl = TextEditingController();
  var color;

  @override
  void initState() {
    super.initState();
    _loadDriver(1, search);
  }

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
        title: const Text('Drivers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1),
                children: List.generate(driverList.length, (index) {
                  return InkWell(
                    splashColor: Colors.green,
                    onTap: () => {_loadDriverDetailsDialog(index)},
                    child: Card(
                        child: Column(
                      children: [
                        Flexible(
                          flex: 8,
                          child: CachedNetworkImage(
                            imageUrl: CONSTANTS.server +
                                "/SapuCar/mobile/assets/Dimages/" +
                                driverList[index].id.toString() +
                                '.jpg',
                            fit: BoxFit.cover,
                            width: resWidth,
                            placeholder: (context, url) =>
                                const LinearProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Flexible(
                            flex: 8,
                            child: Column(
                              children: [
                                Text(
                                  driverList[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Car Model: " +
                                    driverList[index].carModel.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Car Plate No: " +
                                    driverList[index].carPlateNo.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Phone No: " +
                                    driverList[index].phone.toString()),
                              ],
                            ))
                      ],
                    )),
                  );
                }))),
        SizedBox(
          height: 30,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: numofpage,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if ((curpage - 1) == index) {
                color = Colors.red;
              } else {
                color = Colors.black;
              }
              return SizedBox(
                width: 40,
                child: TextButton(
                    onPressed: () => {_loadDriver(index + 1, "")},
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: color),
                    )),
              );
            },
          ),
        ),
      ]),
    );
  }

  _loadDriver(int pageno, String search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/load_driver.php"),
        body: {
          'pageno': pageno.toString(),
          'search': search,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = json.decode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['driverApp'] != null) {
          driverList = <Driver>[];
          extractdata['driverApp'].forEach((v) {
            driverList.add(Driver.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }

  _loadDriverDetailsDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Driver Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/SapuCar/mobile/assets/Dimages/" +
                      driverList[index].id.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  driverList[index].name.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Text("Tutor Name: " + driverAppList[index].tutorName.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Email: " + driverList[index].email.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Gender: " + driverList[index].gender.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Driver Phone No: " + driverList[index].phone.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Matric/Staff No: " +
                      driverList[index].matricStaffNo.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Car Model: " + driverList[index].carModel.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Car Plate No: " +
                      driverList[index].carPlateNo.toString()),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Booking Information: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: dateCtrl,
                    decoration: InputDecoration(
                        labelText: 'Date (31/12/2023)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: timeCtrl,
                    decoration: InputDecoration(
                        labelText: 'Time (12:00PM)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: noPassCtrl,
                    decoration: InputDecoration(
                        labelText: 'No. Of Passengers',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: pickUpCtrl,
                    decoration: InputDecoration(
                        labelText: 'Pick Up Destination',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: dropOffCtrl,
                    decoration: InputDecoration(
                        labelText: 'Drop Off Destination',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text("Create Booking"),
                              onPressed: () {
                                _createBookingDialog(index);
                              })),
                    ),
                  ])
                ]),
              ],
            )),
          );
        });
  }

  _createBookingDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Do you sure to create the booking! ",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _createBooking(index);
                    },
                  ),
                  TextButton(
                    child: const Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        });
  }

  void _createBooking(int index) {
    String driverID = driverList[index].id.toString();
    String passengerEmail = widget.passenger.email.toString();
    String date = dateCtrl.text;
    String time = timeCtrl.text;
    String noPass = noPassCtrl.text;
    String pickUp = pickUpCtrl.text;
    String dropOff = dropOffCtrl.text;
    String bookingStatus = "PENDING";
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/create_booking.php"),
        body: {
          "driverID": driverID,
          "passengerEmail": passengerEmail,
          "date": date,
          "time": time,
          "noPass": noPass,
          "pickUp": pickUp,
          "dropOff": dropOff,
          "bookingStatus": bookingStatus,
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Booking Has Been Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            fontSize: 16.0);
      }
    });
  }

  void _loadSearchDialog() {
    searchCtrl.text = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search Driver",
                ),
                content: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchCtrl,
                        decoration: InputDecoration(
                            labelText: 'Search Driver Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchCtrl.text;
                      Navigator.of(context).pop();
                      _loadDriver(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }
}
