import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sistem_rt/Bloc/bloc/obscure_bloc_bloc.dart';
import 'package:sistem_rt/Controller/ObscureController.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var delok = false;
  final ObscureController obscureController = Get.put(ObscureController());
  
  Column ViewRegister(BuildContext context, {String? msg, String? btn_msg}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "$msg",
              style: TextStyle(
                  fontFamily: "Rubik",
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 80.h,
          ),
          Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: TextFormField(
                        validator: (value) {
                          return (value == null || value.isEmpty)
                              ? 'Mohon isi!'
                              : null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Username",
                        ),
                        style: const TextStyle(fontFamily: "Rubik"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: TextFormField(
                            validator: (value) {
                              return (value == null || value.isEmpty)
                                  ? 'Mohon isi!'
                                  : null;
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      obscureController.changeCondition();
                                      print("iki coeg : ${obscureController.isVisible.value}");
                                      // delok = obscureController.isVisible.value;
                                      setState(() {
                                        
                                      });
                                    },
                                    // onPressed: isOpen,
                                    icon: Icon(obscureController.isVisible.value == true
                                        ? Icons.lock_open
                                        : Icons.visibility_off))),
                            obscureText: obscureController.isVisible.value ,
                            style: const TextStyle(fontFamily: "Rubik"),
                          ),
                        ),
                      ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      splashColor: const Color.fromRGBO(23, 78, 171, 1.0),
                      child: AnimatedContainer(
                        curve: Curves.bounceInOut,
                        duration: const Duration(milliseconds: 100),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.h)),
                          color: const Color.fromRGBO(23, 78, 171, 1.0),
                          child: Center(
                            child: Text(
                              "$btn_msg",
                              style: TextStyle(
                                  fontFamily: "Rubik",
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ViewRegister(context, msg: "Silahkan registrasi", btn_msg: "Daftar" ),
      ),
    );
  }

  
  // void isOpen() {
  //   setState(() {
  //     delok = !delok;
  //   });
  // }
}