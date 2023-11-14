import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";

import "../Controller/ObscureController.dart";
// import "Register.dart";

class Login extends StatefulWidget {
Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var delok = true.obs;

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
                                      // obscureController.changeCondition();
                                      delok.value = !delok.value;
                                      print("iki coeg : ${delok.value}");
                                      // delok = obscureController.isVisible.value;
                                      setState(() {
                                        
                                      });
                                    },
                                    // onPressed: isOpen,
                                    icon: Icon(delok.value == true
                                        ? Icons.lock_open
                                        : Icons.visibility_off))),
                            obscureText: delok.value ,
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
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: ViewRegister(
          context, 
          msg: "Silahkan Login",
          btn_msg: "Login"
        ),
      ),
    );
  }
}
