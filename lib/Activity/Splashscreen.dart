import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/Activity/Login.dart';
import 'package:sistem_rt/Activity/Menu.dart';
import 'package:sistem_rt/Activity/Register.dart';

import '../Controller/LoginController/PrefController.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({ Key? key }) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {

  var prefController = Get.put(PrefController());
  var isEmail;
  
  Future<void> shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isEmail = pref.getString("email");
  }
 

  @override
  void initState() {
  
    shared();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), (){
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => (isEmail != null )? Menu() : Login())
        );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
     overlays: SystemUiOverlay.values);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(23, 78, 171, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(23, 78, 171, 1.0),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset("assets/image/logo.png", fit: BoxFit.cover),
            Text(
              "SIFORA",
              style: TextStyle(
                fontFamily: "Rubik",
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold
              ),),
          ],
        ),
      ),
    );
  }
}