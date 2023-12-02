import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sistem_rt/Activity/KeluargaView.dart";
import "package:sistem_rt/Activity/Profile.dart";
import "package:sistem_rt/Activity/Register.dart";

import "../Controller/LoginController/PrefController.dart";

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var pref = Get.put(PrefController());
  String? user;
  String? ref;

  // Future<String?> shared() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   user = pref.getString("email")!.split("@gmail.com")[0];
  //   ref = pref.getString("refreshToken");
  //   return ref;
  // }

  @override
  void initState() {
    super.initState();
    // shared();
    // user = pref.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
      body: Stack(
        children: [
          Container(
            height: 180.h,
            color: const Color.fromRGBO(23, 78, 171, 1.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 70.h, left: 20.dm),
                  child: FutureBuilder(
                    future: pref.getEmail(),
                    // future: shared(),
                    builder: (_, snapshot) {
                    return (snapshot.connectionState == ConnectionState.done)? RichText(
                        text: TextSpan(
                            text: "Hi,\n",
                            style:
                                TextStyle(fontSize: 17.sp, fontFamily: "Rubik"),
                            children: [
                          TextSpan(
                              text: "${snapshot.data}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Rubik",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold))
                        ])) : const CircularProgressIndicator();
                  })),
              Padding(
                padding: EdgeInsets.only(top: 70.h, right: 20.dm),
                child: SizedBox(
                  height: 50.dm,
                  width: 50.dm,
                  child: IconButton(
                      color: Colors.grey,
                      hoverColor: Colors.grey,
                      onPressed: () {
                        log("$ref");
                        Get.to(() => Profile());
                      },
                      icon: const Icon(
                        Icons.person_3,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.h, right: 10.h, left: 10.h),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              children: [
                CardMenu(context,
                    icon: Icons.family_restroom,
                    name: "Keluarga",
                    page: const KeluargaView()),
                CardMenu(context, icon: Icons.money, name: "Keuangan"),
                CardMenu(context, icon: Icons.event, name: "Event"),
                CardMenu(context,
                    icon: Icons.account_box,
                    name: "Admin",
                    page: const Register()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CardMenu(BuildContext context,
      {IconData? icon, String? name, dynamic page}) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.h),
      child: InkWell(
        splashColor: Colors.blue,
        hoverColor: Colors.blue,
        onTap: () {
          Get.to(page);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.h)),
            elevation: 6,
            color: Colors.white,
            shadowColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(194, 216, 252, 1),
                      borderRadius: BorderRadius.circular(45.h)),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Color.fromRGBO(23, 78, 171, 1.0),
                    ),
                  ),
                ),
                Text(
                  "$name",
                  style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
