import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sapucar/Amainscreen.dart';
import 'package:sapucar/Aregisterscreen.dart';
import 'package:sapucar/charscreen.dart';
import 'package:sapucar/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sapucar/model/admin.dart';

class ALoginScreen extends StatefulWidget {
  const ALoginScreen({Key? key}) : super(key: key);

  @override
  State<ALoginScreen> createState() => _ALoginScreenState();
}

class _ALoginScreenState extends State<ALoginScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int cart = 0;

  @override
  void initState() {
    super.initState();
    loadPref();
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
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: ctrwidth,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: screenHeight / 2.5,
                              width: screenWidth,
                              child: Image.asset(
                                  'assets/images/UUMGO SC_Admin.png')),
                          const Text(
                            "Admin Login",
                            style: TextStyle(fontSize: 25),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid email';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);

                              if (!emailValid) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: remember,
                                onChanged: (bool? value) {
                                  _onRememberMeChanged(value!);
                                },
                              ),
                              const Text("Remember Me")
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  child: const Text("Login"),
                                  onPressed: _loginAdmin,
                                ),
                              ),
                              const SizedBox(
                                width: 45,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  child: const Text(
                                    "Exit",
                                    style: TextStyle(),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (content) =>
                                                const SCCharScreen()));
                                  },
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       width: 150,
                          //       height: 50,
                          //       child: ElevatedButton(
                          //         child: const Text("Register"),
                          //         onPressed: _registerAdminScreen,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _saveRemovePref(bool value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _emailController.text;
      String password = _passwordController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value) {
        await prefs.setString('email', email);
        await prefs.setString('pass', password);
        await prefs.setBool('remember', true);
        Fluttertoast.showToast(
            msg: "Preference Stored",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      } else {
        await prefs.setString('email', '');
        await prefs.setString('pass', '');
        await prefs.setBool('remember', false);
        _emailController.text = "";
        _passwordController.text = "";
        Fluttertoast.showToast(
            msg: "Preference Removed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Preference Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      remember = false;
    }
  }

  void _onRememberMeChanged(bool value) {
    remember = value;
    setState(() {
      if (remember) {
        _saveRemovePref(true);
      } else {
        _saveRemovePref(false);
      }
    });
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    remember = (prefs.getBool('remember')) ?? false;

    if (remember) {
      setState(() {
        _emailController.text = email;
        _passwordController.text = password;
        remember = true;
      });
    }
  }

  void _registerAdminScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (content) => const AregisterScreen()));
  }

  void _loginAdmin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.post(
          Uri.parse(CONSTANTS.server + "/SapuCar/mobile/php/login_admin.php"),
          body: {
            "email": _emailController.text,
            "password": _passwordController.text
          }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Login Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          var extractdata = data['data'];
          Admin admin = Admin.fromJson(extractdata);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => AMainScreen(
                        admin: admin,
                      )));
        } else {
          Fluttertoast.showToast(
              msg: "Login Failed, email or password are incorrect",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              fontSize: 16.0);
        }
      });
    }
  }
}
