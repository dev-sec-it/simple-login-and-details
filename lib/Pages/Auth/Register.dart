import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_login_and_details/Pages/Auth/Login.dart';
import 'package:simple_login_and_details/config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register account"),
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
                http.Response resp = await http.post(Uri.parse(APP_API), body: {
                  "email": email.text,
                  "password": password.text,
                  "register": "true"
                });
                print(
                    "Server Response :: Register : - " + resp.body.toString());
                if (resp.body.toString() == "Success") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                }
              },
              child: Text("Register"))
        ],
      ),
    );
  }
}
