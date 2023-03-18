import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_and_details/Pages/Auth/Login.dart';
import 'package:simple_login_and_details/Pages/HomeScreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var uid;
  getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        uid = prefs.getString("uid");
      } catch (e) {}
    });
  }

  @override
  void initState() {
    getUID();
    // TODO: implement initState
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  uid != null ? HomeScreen(uid: uid) : LoginScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is splash Screen"),
      ),
    );
  }
}
