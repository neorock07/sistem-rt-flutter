import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistem_rt/Activity/Partials/BaseCard.dart';

Widget CardEvent(BuildContext context,
    {String? image,
    String? title,
    String? lokasi,
    String? date,
    dynamic func}) {
  return BaseCard(
      context,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: 5,
      [
        Container(
            // color: Colors.white,
            height: 80.h,
            width: double.maxFinite,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.dm),
                ),
                image: DecorationImage(image: NetworkImage(
                    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEtTpJvBhqeI1a5Q7KLKuYr7Et5LU-5uJ4lB1B2Yf49LoQLHSAW9fL5n6Q9N9lwl_RB8A&usqp=CAU",
                    "${image}"), fit: BoxFit.fill))),
        Padding(
          padding: EdgeInsets.only(top: 8.0.dm, left: 8.dm, bottom: 8.dm),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${title}",
              style: TextStyle(
                  fontFamily: "Rubik",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0.dm),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  size: 15,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "${lokasi}",
                  style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0.dm),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 15,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "${date}",
                  style: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(5.0.dm),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0)),
                onPressed: func,
                child: const Text(
                  "Lihat",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        )
      ],
      const Color.fromRGBO(23, 78, 171, 1.0));
}
