import 'dart:async';
import 'package:ecommercapp/const/appcolor.dart';
import 'package:ecommercapp/ui/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Startwidget extends StatefulWidget {
  const Startwidget({Key? key}) : super(key: key);

  @override
  _StartwidgetState createState() => _StartwidgetState();
}

class _StartwidgetState extends State<Startwidget> {
  void initState() {
    Timer(
        Duration(seconds: 1),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => Loginwidget())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor.mycolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "E-Commerce",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 44.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
