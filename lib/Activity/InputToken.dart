import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sistem_rt/Activity/Register.dart';
import 'package:sistem_rt/Controller/TokenVerifController/TokenVerifController.dart';

class InputToken extends StatefulWidget {
  const InputToken({Key? key}) : super(key: key);

  @override
  _InputTokenState createState() => _InputTokenState();
}

class _InputTokenState extends State<InputToken> {
  final _formKey = GlobalKey<FormState>();
  var tokenController = TextEditingController();
  var postToken = TokenVerifController();
  bool? condition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            "Silahkan isi token untuk menunjukkan\nbahwa Anda adalah Superadmin!",
            style: TextStyle(
                color: Colors.grey, fontFamily: "Rubik", fontSize: 15.sp),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.h),
                  child: TextField(
                      autofocus: true,
                      style: TextStyle(fontFamily: "Rubik", fontSize: 20.sp),
                      textAlign: TextAlign.center,
                      controller: tokenController,
                      decoration: InputDecoration(
                        // label: Text(""),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide: const BorderSide(
                                width: 2.0,
                                color: Color.fromRGBO(23, 78, 171, 1.0))),
                      )),
                ),
              ],
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
             await postToken.VerifSuper(tokenController.text).then((value) {
                setState(() {
                condition = value;
                });
              });
              if (condition != null) {
              log("input : ${tokenController.text} | ${condition}");
                if (condition == true) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Register();
                  }));
                } else {
                  Get.snackbar("Toke Salah", "Anda tidak diperkenankan masuk");
                }
              }
            },
            splashColor: const Color.fromRGBO(23, 78, 171, 1.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(23, 78, 171, 1.0),
                  borderRadius: BorderRadius.circular(10.h)),
              child: Center(
                child: Text(
                  "Verifikasi",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Rubik",
                      fontSize: 18.sp),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
