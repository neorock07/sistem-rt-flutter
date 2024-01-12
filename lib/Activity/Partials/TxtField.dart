import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sistem_rt/Controller/TextFieldController.dart';

var txtClearController = Get.put(ClearFieldController());

Widget TxtField(BuildContext context,
    {GlobalKey? key,
    String? label,
    String? init,
    int? maxline,
    TextInputType? keyboardType,
    TextEditingController? controller}) {
  return Padding(
    padding: EdgeInsets.only(left: 5.w, right: 5.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          // initialValue: init,
          controller: controller,
          // textCapitalization: TextCapitalization.characters,
          keyboardType:
              (keyboardType != null) ? keyboardType : TextInputType.text,
          maxLines:(maxline != null) ? 4: 1,    
          decoration: InputDecoration(
            label: Text("$label"),
          ),
        )
      ],
    ),
  );
}
