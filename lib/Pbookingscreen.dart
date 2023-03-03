import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:sapucar/model/booking.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sapucar/model/passenger.dart';
import 'model/passenger.dart';

class PBookingScreen extends StatefulWidget {
  final Passenger passenger;
  const PBookingScreen({Key? key, required this.passenger}) : super(key: key);

  @override
  State<PBookingScreen> createState() => _PBookingScreenState();
}

class _PBookingScreenState extends State<PBookingScreen> {
  late double screenHeight, screenWidth, resWidth;
  int currentIndex = 0;
  List<Booking> bookingList = <Booking>[];
  String titlecenter = "Your booking is empty...";
  var color;

  @override
  void initState() {
    super.initState();
    _loadBookings();
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Booking'),
    //   ),
    //   body: Column(children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8),
    //       child: Text(titlecenter,
    //           style:
    //               const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //     ),
    //     Expanded(
    //         child: GridView.count(
    //             crossAxisCount: 2,
    //             childAspectRatio: (1 / 1),
    //             children: List.generate(driverList.length, (index) {
    //               return InkWell(
    //                 splashColor: Colors.green,
    //                 onTap: () => {_loadDriverDetailsDialog(index)},
    //                 child: Card(
    //                     child: Column(
    //                   children: [
    //                     Flexible(
    //                       flex: 8,
    //                       child: CachedNetworkImage(
    //                         imageUrl: CONSTANTS.server +
    //                             "/SapuCar/mobile/assets/Dimages/" +
    //                             driverList[index].id.toString() +
    //                             '.jpg',
    //                         fit: BoxFit.cover,
    //                         width: resWidth,
    //                         placeholder: (context, url) =>
    //                             const LinearProgressIndicator(),
    //                         errorWidget: (context, url, error) =>
    //                             const Icon(Icons.error),
    //                       ),
    //                     ),
    //                     Flexible(
    //                         flex: 8,
    //                         child: Column(
    //                           children: [
    //                             Text(
    //                               driverList[index].name.toString(),
    //                               style: const TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             const SizedBox(
    //                               height: 5,
    //                             ),
    //                             Text("Car Model: " +
    //                                 driverList[index].carModel.toString()),
    //                             const SizedBox(
    //                               height: 5,
    //                             ),
    //                             Text("Car Plate No: " +
    //                                 driverList[index].carPlateNo.toString()),
    //                             const SizedBox(
    //                               height: 5,
    //                             ),
    //                             Text("PhoneNo: " +
    //                                 driverList[index].phone.toString()),
    //                           ],
    //                         ))
    //                   ],
    //                 )),
    //               );
    //             }))),
    //     SizedBox(
    //       height: 30,
    //       child: ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: numofpage,
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (context, index) {
    //           if ((curpage - 1) == index) {
    //             color = Colors.red;
    //           } else {
    //             color = Colors.black;
    //           }
    //           return SizedBox(
    //             width: 40,
    //             child: TextButton(
    //                 onPressed: () => {_loadDriver(index + 1, "")},
    //                 child: Text(
    //                   (index + 1).toString(),
    //                   style: TextStyle(color: color),
    //                 )),
    //           );
    //         },
    //       ),
    //     ),
    //   ]),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: bookingList.isEmpty
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
                    child: Text("Your Bookings",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(color: Colors.grey),
                  Expanded(
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1),
                          children: List.generate(bookingList.length, (index) {
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  _loadBookingDetailsDialog(index);
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
                                                child: Text(" : " +
                                                  bookingList[index]
                                                      .bookingID
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
                                                child: Text(" : " +
                                                  bookingList[index]
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
                                                child: Text(" : " +
                                                      bookingList[index]
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
                                                child: Text(" : " +
                                                  bookingList[index]
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
                                                child: Text(" : " +
                                                      bookingList[index]
                                                          .dropOff
                                                          .toString(),
                                                ),
                                              )
                                            ]),
                                            TableRow(children: [
                                              const TableCell(
                                                child: Text(
                                                  "Car Model ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              TableCell(
                                                child: Text(" : " +
                                                      bookingList[index]
                                                          .carModel
                                                          .toString(),
                                                ),
                                              )
                                            ]),
                                            TableRow(children: [
                                              const TableCell(
                                                child: Text(
                                                  "Car No. ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              TableCell(
                                                child: Text(" : " +
                                                      bookingList[index]
                                                          .carPlateNo
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
                                                child: Text(" : " +
                                                      bookingList[index]
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
    );
  }

  _loadBookings() {
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/load_bookings.php"),
        body: {
          'passenger_email': widget.passenger.email,
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
          bookingList = <Booking>[];
          extractdata['bookings'].forEach((v) {
            bookingList.add(Booking.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }

  _loadBookingDetailsDialog(int index) {
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
                      "/SapuCar/mobile/assets/Dimages/" +
                      bookingList[index].driverID.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  bookingList[index].driverName.toString(),
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
                  Text("Booking ID: " + bookingList[index].bookingID.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Email: " + bookingList[index].driverEmail.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Gender: " + bookingList[index].gender.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Phone No: " + bookingList[index].driverPhone.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Car Model: " + bookingList[index].carModel.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Car Plate No: " +
                      bookingList[index].carPlateNo.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking Date: " + bookingList[index].bookingDate.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking Time: " + bookingList[index].bookingTime.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Pick Up Destination: " + bookingList[index].pickUp.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Drop Off Destination: " + bookingList[index].dropOff.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Booking Status: " + bookingList[index].status.toString()),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text("Cancel Booking"),
                              onPressed: () {
                                _cancelBookingDialog(index);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red))),
                    ),
                  ])
                ]),
              ],
            )),
          );
        });
  }

  _cancelBookingDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Do you sure to cancel the booking! ",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _cancelBooking(index);
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

  void _cancelBooking(int index) {
    String bookingID = bookingList[index].bookingID.toString();
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/cancel_booking.php"),
        body: {
          "bookingID": bookingID,
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Booking Has Been Cancelled",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

}
