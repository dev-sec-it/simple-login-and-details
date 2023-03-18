import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_login_and_details/Pages/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:simple_login_and_details/config.dart';
import 'package:simple_login_and_details/update.dart';

import 'Pages/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isUpdateAvailable = false;

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    http.Response v =
        await http.post(Uri.parse(APP_API), body: {"version": "true"});
    print("Version from server :: " + v.body.toString());

    if (int.parse(v.body.replaceAll(".", "")) >
        int.parse(version.replaceAll(".", ""))) {
      print("Update available");
      isUpdateAvailable = true;
      setState(() {});
      return "true";
    } else {
      isUpdateAvailable = false;
      setState(() {});

      print("App Version " + version.toString().replaceAll(".", ""));
      return "false";
    }
  }

  @override
  void initState() {
    getVersion();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isUpdateAvailable ? UpdateScreen() : Splash(),
    );
  }
}
