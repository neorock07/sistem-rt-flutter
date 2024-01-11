import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sistem_rt/Controller/ObscureController.dart';

import '../Controller/LoginController/PrefController.dart';
import '../Controller/RegisterController/RegisterController.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var delok = false;
  var kkController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwdController = TextEditingController();
  final ObscureController obscureController = Get.put(ObscureController());
  final RegisterController registerController = Get.put(RegisterController());

  var pref = Get.put(PrefController());
  String? token;

  // Future<void> shared() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   token = pref.getString("token");
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   shared();
  // }

  Column ViewRegister(BuildContext context, {String? msg, String? btn_msg}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 80.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.2 / 2),
            child: Text(
              "$msg",
              style: TextStyle(
                  fontFamily: "Rubik",
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold),
            ),
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
                      controller: kkController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon isi!'
                            : null;
                      },
                      decoration: const InputDecoration(
                          hintText: "No. Kk", label: Text("No. KK")),
                      style: const TextStyle(fontFamily: "Rubik"),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon isi!'
                            : null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Email", label: Text("Email")),
                      style: const TextStyle(fontFamily: "Rubik"),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon isi!'
                            : null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Username", label: Text("Username")),
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
                      controller: passwdController,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Mohon isi!'
                            : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          label: Text("Password"),
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscureController.changeCondition();
                                print(
                                    "iki coeg : ${obscureController.isVisible.value}");
                                // delok = obscureController.isVisible.value;
                                setState(() {});
                              },
                              // onPressed: isOpen,
                              icon: Icon(
                                  obscureController.isVisible.value == true
                                      ? Icons.lock_open
                                      : Icons.visibility_off))),
                      obscureText: obscureController.isVisible.value,
                      style: const TextStyle(fontFamily: "Rubik"),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      registerController
                          .register(
                              kk: kkController.text,
                              email: emailController.text,
                              username: usernameController.text,
                              password: passwdController.text,
                              );
                          // .then((value) => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const KeluargaView())
                          //         ));
                    },
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
                ),
                
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
        child: ViewRegister(context,
            msg: "Mendaftarkan Akun\nAdmin", btn_msg: "Daftar"),
      ),
    );
  }

  // void isOpen() {
  //   setState(() {
  //     delok = !delok;
  //   });
  // }
}
