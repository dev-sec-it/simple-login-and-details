import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_and_details/Pages/Auth/Register.dart';
import 'package:simple_login_and_details/Pages/HomeScreen.dart';
import 'package:simple_login_and_details/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: email,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              controller: password,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (email.text.toString() != "null" &&
                    password.text.toString() != "null") {
                  http.Response resp = await http.post(Uri.parse(APP_API),
                      body: {
                        "email": email.text,
                        "password": password.text,
                        "login": "true"
                      });
                  print("Login response " + resp.body.toString());
                  if (resp.body.toString() != "failed") {
                    // login success
                    List user = [];
                    user = jsonDecode(resp.body);
                    var uid = user[0]['id'];
                    var name = user[0]['name'];
                    var email = user[0]['email'];

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("uid", uid);
                    prefs.setString("name", name);
                    prefs.setString("email", email);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomeScreen(uid: uid)));
                  } else {
                    // login credential is invalid
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                  "Please check your username and password"),
                            ));
                  }
                }
              },
              child: Text("Login")),
          SizedBox(
            height: 45,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: Text("Create an account"))
        ],
      ),
    );
  }
}
