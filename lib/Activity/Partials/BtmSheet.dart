import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future btmSheet(BuildContext context, {
  dynamic? value,
  String? name,
  dynamic? group  
}){
  return showModalBottomSheet(
    context: context,
    builder: (context){
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              value: value,
              groupValue: group,
              onChanged: (dynamic msg){

              }
              )
          ],
        ),
      );
    }
    ); 
}