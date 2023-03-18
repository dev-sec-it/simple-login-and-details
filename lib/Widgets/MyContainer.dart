import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  var title;
  MyContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 187, 156, 153),
          borderRadius: BorderRadius.circular(20)),
      child: Text(title),
    );
  }
}
