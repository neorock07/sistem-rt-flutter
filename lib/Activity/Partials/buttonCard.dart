import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buttonCard(BuildContext context, {
  Color? color,
  String? label,
  num? width,
  num? height,
  dynamic func
}) {
  return InkWell(
    onTap: func,
    child: Container(
      height:(height == null)? MediaQuery.of(context).size.height * 0.08 : MediaQuery.of(context).size.height * height!,
      width: (width == null)? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * width!,
      decoration: BoxDecoration(
          color: (color == null)? const Color.fromRGBO(23, 78, 171, 1.0) : color,
          borderRadius: BorderRadius.circular(10.h)),
      child: Center(
        child: Text(
          "$label",
          style: TextStyle(
              color: Colors.white, fontFamily: "Rubik", fontSize: 18.sp),
        ),
      ),
    ),
  );
}
