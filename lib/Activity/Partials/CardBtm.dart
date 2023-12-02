import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget cardBtm(BuildContext context,
    {String? label, Color? color, dynamic goto, num? width, num? height}) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => goto));
    },
    child: Container(
      height:(height == null)? MediaQuery.of(context).size.height * 0.08 : MediaQuery.of(context).size.height * height!,
      width: (width == null)? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * width!,
      decoration: BoxDecoration(
          // color: color,
          border: Border.all(
            color: color!,
          ),
          borderRadius: BorderRadius.circular(10.h)),
      child: Center(
        child: Text(
          "$label",
          style: TextStyle(
              color: Colors.black, fontFamily: "Rubik", fontSize: 18.sp),
        ),
      ),
    ),
  );
}
