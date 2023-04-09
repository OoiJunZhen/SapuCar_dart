import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:sapucar/model/Pbooking.dart';
import 'package:sapucar/model/driver.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DPassengerBookingScreen extends StatefulWidget {
  final Driver driver;
  const DPassengerBookingScreen({Key? key, required this.driver})
      : super(key: key);

  @override
  State<DPassengerBookingScreen> createState() =>
      _DPassengerBookingScreenState();
}

class _DPassengerBookingScreenState extends State<DPassengerBookingScreen> {
  late double screenHeight, screenWidth, resWidth;
  int currentIndex = 0;
  List<PBooking> pbookingList = <PBooking>[];
  String titlecenter = "Passenger Bookings is empty.";
  var color;

  @override
  void initState() {
    super.initState();
    _loadPBookings();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/load_pbooking.php"),
        body: {
          'driver_id': widget.driver.id,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = json.decode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];

        if (extractdata['bookings'] != null) {
          pbookingList = <PBooking>[];
          extractdata['bookings'].forEach((v) {
            pbookingList.add(PBooking.fromJson(v));
          });
        }
        setState(() {});
      }
    });
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
          title: const Text('Passenger Bookings'),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: pbookingList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(titlecenter,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Passenger Bookings",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      const Divider(color: Colors.grey),
                      Expanded(
                          child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: (1 / 0.9),
                              children:
                                  List.generate(pbookingList.length, (index) {
                                return Card(
                                  child: InkWell(
                                    onTap: () {
                                      _loadPBookingDetailsDialog(index);
                                      _loadPBookings();
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Table(
                                              columnWidths: const {
                                                0: FlexColumnWidth(4),
                                                1: FlexColumnWidth(6),
                                              },
                                              // border: const TableBorder(
                                              //     verticalInside: BorderSide(
                                              //         width: 1,
                                              //         color: Colors.blue,
                                              //         style: BorderStyle.solid)),
                                              children: [
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Booking ID ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .bookingID
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Name ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .passengerName
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Phone No. ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .passengerPhone
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Date ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .bookingDate
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Time ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .bookingTime
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Pick Up ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .pickUp
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Drop Off ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .dropOff
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                                TableRow(children: [
                                                  const TableCell(
                                                    child: Text(
                                                      "Status ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Text(
                                                      " : " +
                                                          pbookingList[index]
                                                              .status
                                                              .toString(),
                                                    ),
                                                  )
                                                ]),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                );
                              }))),
                    ]),
                  ),
                ),
        ));
  }

  _loadPBookings() {
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/load_pbooking.php"),
        body: {
          'driver_id': widget.driver.id,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = json.decode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];

        if (extractdata['bookings'] != null) {
          pbookingList = <PBooking>[];
          extractdata['bookings'].forEach((v) {
            pbookingList.add(PBooking.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }

  _loadPBookingDetailsDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Booking Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/SapuCar/mobile/assets/Pimages/" +
                      pbookingList[index].pID.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  pbookingList[index].passengerName.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking ID: " +
                      pbookingList[index].bookingID.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Passenger Gender: " +
                      pbookingList[index].passengerGender.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Passenger Phone No: " +
                      pbookingList[index].passengerPhone.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking Date: " +
                      pbookingList[index].bookingDate.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking Time: " +
                      pbookingList[index].bookingTime.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("No. Of Passenger: " +
                      pbookingList[index].noPass.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Pick Up Destination: " +
                      pbookingList[index].pickUp.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Drop Off Destination: " +
                      pbookingList[index].dropOff.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking Status: " +
                      pbookingList[index].status.toString()),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: 60,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text("RECEIVE"),
                              onPressed: () {
                                _receiveBookingDialog(index);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green))),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: 60,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text("REJECT"),
                              onPressed: () {
                                _rejectBookingDialog(index);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red))),
                    ),
                  ])
                ]),
              ],
            )),
          );
        });
    setState(() {});
  }

  _receiveBookingDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Are you sure to receive this booking! ",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _receiveBooking(index);
                      _loadPBookings();
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

  _rejectBookingDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Are you sure to reject this booking! ",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _rejectBooking(index);
                      _loadPBookings();
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

  void _receiveBooking(int index) {
    String bookingID = pbookingList[index].bookingID.toString();
    String statusBooking = "RECEIVED";
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/receive_booking.php"),
        body: {
          "bookingID": bookingID,
          "statusBooking": statusBooking,
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Booking Has Been Received",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            fontSize: 16.0);
      }
    });
  }

  void _rejectBooking(int index) {
    String bookingID = pbookingList[index].bookingID.toString();
    String statusBooking = "REJECTED";
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/reject_booking.php"),
        body: {
          "bookingID": bookingID,
          "statusBooking": statusBooking,
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Booking Has Been Rejected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            fontSize: 16.0);
      }
    });
  }
}
