import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/user_model.dart';
import 'package:ifgpadmin/screens/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User? user;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();

  login() async {
    var url = Uri.parse('http://35.213.159.134/loginadmin.php');

    try {
      var response = await http.post(url, body: {
        "Email": emailcontroller.text,
        "Passwordd": passwordcontroller.text,
      });

      var admindata = json.decode(response.body);
      // print('result = $result');

      // check authentication
      if (admindata == "error") {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Email or Password invalid',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ],
              ),
              backgroundColor: Colors.red.shade700,
            ),
          );
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Welcome ifgp admin',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    CupertinoIcons.checkmark_alt_circle_fill,
                    color: Colors.white,
                  ),
                ],
              ),
              backgroundColor: Colors.blue.shade900,
            ),
          );
        await delay(1200);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return DashboardScreen(
                email: admindata['Email'], username: admindata['Username']);
          }),
          (route) => false,
        );
        // print('id admin login : ${admindata['ID_Admin']}');
      }
    } catch (e) {}
  }

  // delay
  Future<void> delay(int millisec) async {
    // print('delay start');
    await Future.delayed(Duration(milliseconds: millisec));
    // print('delay end');
  }

  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 200),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // text
                  Container(
                    height: 70.0,
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WELCOME",
                          style: GoogleFonts.domine(
                              color: Colors.black,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "ifgp admin.",
                          style: GoogleFonts.domine(
                            color: Colors.black,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 70),

                  // textfield email + password
                  GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.only(top: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              final pattern =
                                  r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                              final regExp = RegExp(pattern);

                              if (value!.isEmpty) {
                                return "please enter your email";
                              } else if (!regExp.hasMatch(value)) {
                                return "please enter a valid email";
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: emailcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email,
                                  size: 20, color: Colors.black),
                              suffixIcon: emailcontroller.text.isEmpty
                                  ? Container(width: 0)
                                  : GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onTap: () => emailcontroller.clear(),
                                    ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 10.0, right: 10.0),
                              labelText: "Email",
                              hintText: "name@example.com",
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            autocorrect: false,
                            cursorColor: Colors.black,
                          ),
                          SizedBox(height: 21),

                          // password
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your password";
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: passwordcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock,
                                  size: 20, color: Colors.black),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                child: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 18,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 10.0, right: 10.0),
                              labelText: "Password",
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            autocorrect: false,
                            cursorColor: Colors.black,
                            obscureText: showPassword,
                          ),
                          SizedBox(height: 80),

                          // login button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                elevation: 0.8,
                                minimumSize: Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
