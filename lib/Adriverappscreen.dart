import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:sapucar/Amainscreen.dart';
import 'package:sapucar/model/driver.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:sapucar/model/admin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ADriverAppScreen extends StatefulWidget {
  final Admin admin;
  const ADriverAppScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<ADriverAppScreen> createState() => _ADriverAppScreenState();
}

// Future<void> _refresh() async {
//   await Future.delayed(Duration(seconds: 1));
// }

class _ADriverAppScreenState extends State<ADriverAppScreen> {
  late double screenHeight, screenWidth, resWidth;
  var numofpage, curpage = 1;
  int currentIndex = 0;
  List<Driver> driverAppList = <Driver>[];
  var color;

  @override
  void initState() {
    super.initState();
    _loadDriverApp(1);
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
        title: const Text('Driver Application'),
      ),
      // body: RefreshIndicator(
      //   onRefresh: _refresh,
      body: Column(children: [
        Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1),
                children: List.generate(driverAppList.length, (index) {
                  return InkWell(
                    splashColor: Colors.green,
                    onTap: () => {
                      _loadDriverAppDetailsDialog(index),
                      _loadDriverApp(curpage)
                    },
                    child: Card(
                        child: Column(
                      children: [
                        Flexible(
                          flex: 8,
                          child: CachedNetworkImage(
                            imageUrl: CONSTANTS.server +
                                "/SapuCar/mobile/assets/Dimages/" +
                                driverAppList[index].id.toString() +
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
                                  driverAppList[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Car Model: " +
                                    driverAppList[index].carModel.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Car Plate No: " +
                                    driverAppList[index].carPlateNo.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Phone No: " +
                                    driverAppList[index].phone.toString()),
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
                    onPressed: () => {_loadDriverApp(index + 1)},
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

  _loadDriverApp(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/load_driverApp.php"),
        body: {
          'pageno': pageno.toString(),
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
          driverAppList = <Driver>[];
          extractdata['driverApp'].forEach((v) {
            driverAppList.add(Driver.fromJson(v));
          });
        }
        setState(() {});
      }
    });
  }

  _loadDriverAppDetailsDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Driver Application Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/SapuCar/mobile/assets/Dimages/" +
                      driverAppList[index].id.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  driverAppList[index].name.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Text("Tutor Name: " + driverAppList[index].tutorName.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver IC No: " + driverAppList[index].ICno.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Driver Email: " + driverAppList[index].email.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Gender: " +
                      driverAppList[index].gender.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Phone No: " +
                      driverAppList[index].phone.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver Matric/Staff No: " +
                      driverAppList[index].matricStaffNo.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Car Model: " + driverAppList[index].carModel.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Car Plate No: " +
                      driverAppList[index].carPlateNo.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Driver License No: " +
                      driverAppList[index].licenseNo.toString()),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("UUM Car Sticker No: " +
                      driverAppList[index].stickerNo.toString()),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Status: " + driverAppList[index].status.toString()),
                  const SizedBox(
                    height: 15,
                  ),
                  // style: const TextStyle(fontWeight: FontWeight.bold)
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: 60,
                          height: 50,
                          child: ElevatedButton(
                              child: const Text("APPROVE"),
                              onPressed: () {
                                _approveDriverDialog(index);
                              })),
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
                                _rejectDriverDialog(index);
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
  }

  _approveDriverDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Do you sure to approve this driver! ",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (content) => AMainScreen(admin: widget.admin)));
                      Navigator.of(context).pop();
                      _approveDriver(index);
                      _loadDriverApp(curpage);
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

  _rejectDriverDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Do you sure to reject this driver! ",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _rejectDriver(index);
                      _loadDriverApp(curpage);
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

  void _approveDriver(int index) {
    String driverAppID = driverAppList[index].id.toString();
    String statusApproved = "Approved";
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/approve_driver.php"),
        body: {
          "driverAppID": driverAppID,
          "statusApproved": statusApproved,
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        // print(jsondata['data']['status'].toString());
        // setState(() {
        //   driverAppList[index].status = jsondata['data']['status'].toString();
        // });
        Fluttertoast.showToast(
            msg: "Driver Has Been Approved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  void _rejectDriver(int index) {
    String driverAppID = driverAppList[index].id.toString();
    String statusRejected = "Rejected";
    http.post(
        Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/reject_driver.php"),
        body: {
          "driverAppID": driverAppID,
          "statusRejected": statusRejected,
        }).then((response) {
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Driver Has Been Rejected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}
