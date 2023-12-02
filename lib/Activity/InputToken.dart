import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputToken extends StatefulWidget {
  const InputToken({Key? key}) : super(key: key);

  @override
  _InputTokenState createState() => _InputTokenState();
}

class _InputTokenState extends State<InputToken> {
  final _formKey = GlobalKey<FormState>();
  var tokenController = TextEditingController();

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
                      style: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 20.sp
                      ),
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
            ))
      ]),
    );
  }
}
