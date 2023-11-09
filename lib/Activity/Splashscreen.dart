import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistem_rt/Activity/Register.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({ Key? key }) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Register())
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
        child: Text(
          "Sistem RT",
          style: TextStyle(
            fontFamily: "Rubik",
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold
          ),),
      ),
    );
  }
}