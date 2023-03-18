import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_and_details/Pages/Auth/Login.dart';
import 'package:http/http.dart' as http;
import 'package:simple_login_and_details/Widgets/MyContainer.dart';
import 'package:simple_login_and_details/config.dart';

class HomeScreen extends StatefulWidget {
  var uid;
  HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List user = [];
  getAllUser() async {
    http.Response resp =
        await http.post(Uri.parse(APP_API), body: {"alluser": "true"});
    print("Srever Response for all user" + resp.body.toString());
    user = jsonDecode(resp.body.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("uid");
                prefs.remove("name");
                prefs.remove("email");
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: user.length < 1
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: user.length,
              itemBuilder: (c, int x) {
                return MyContainer(title: user[x]['name'].toString());
              },
            ),
      // body: user.length < 1
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : ListView(
      //         children: [
      //           for (var x = 0; x < user.length; x++)
      //             Container(
      //               height: 120,
      //               width: MediaQuery.of(context).size.width,
      //               margin: EdgeInsets.all(20),
      //               color: Colors.red,
      //               child: Text(user[x]['name'].toString()),
      //             ),
      //         ],
      //       ),
    );
  }
}
