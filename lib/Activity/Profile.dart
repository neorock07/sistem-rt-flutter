import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/Activity/Splashscreen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  SharedPreferences? pref;
  Future<void> shared() async {
    pref = await SharedPreferences.getInstance();
    
  }

  @override
  void initState() {
    super.initState();
    shared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(onPressed: () {
          pref!.clear().then((value) => Get.to(()=> Splashscreen()));
        }, child: Text("Log Out")),
      ),
    );
  }
}
