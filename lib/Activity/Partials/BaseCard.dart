import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BaseCard(BuildContext context,
 List<Widget> children,
Color? color,{
  double? width,
  double? padding
}) {
  return Container(
    height: 175.dm,
    width: (width != null)? width : MediaQuery.of(context).size.width * 0.95,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(10.h)),
    ),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all( (padding != null)? padding : 10.dm),
        child: Column(
          children: children,
        ),
      ),
    ),
  );
}
