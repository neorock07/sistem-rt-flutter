import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sistem_rt/Activity/Partials/DragSheet.dart';
import 'package:sistem_rt/Controller/EventController/EventController.dart';
import 'package:sistem_rt/Utils/Ip.dart';
import 'package:sistem_rt/Utils/convertTime.dart';

import '../API/Model/EventModel/EventModel.';

class DetailEvent extends StatefulWidget {
  String? id;
  DetailEvent({super.key, this.id});

  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  var ipAdd = Ip();
  // var controller = Get.put(EventController());
  // Rx<EventModel> data
  EventModel data = EventModel();
  var convert = convertTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Colors.white,
        body: GetBuilder<EventController>(
          init: EventController(),
          initState: (state) async {
            await EventController().findById(widget.id!).then((value) {
              data = value;
              log("data iki cuy : ${data.deskripsi}");
              setState(() {});
            });
          },
          builder: (snap) {
            return (data.fileUrl == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${ipAdd.getType()}://${ipAdd.getIp()}${data!.fileUrl!.substring(24)}"),
                                fit: BoxFit.cover)),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 20.h),
                        child: IconButton(
                          onPressed: () async {
                            // final box =
                            //     context.findRenderObject() as RenderBox?;
                            // await Share.share(
                            //   "--------ADA EVENT NIH!---------\n- apa? ${data.title}\n- kapan? ${convert.convert(data.date).substring(0, 11)}\n${convert.convert(data.date).substring(11, 17)} WIB\n- dimana? ${data.lokasi}\n*Ayo datang dan hitamkan!*",
                            //   subject: "Inpo event",
                            //   sharePositionOrigin:
                            //       box!.localToGlobal(Offset.zero) & box.size,
                            // );
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.orange,
                        ),
                      ),
                      DraggableScrollableSheet(
                          initialChildSize: 0.7,
                          minChildSize: 0.6,
                          maxChildSize: 0.9,
                          builder: ((context, scrollController) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.dm),
                                        topRight: Radius.circular(15.dm))),
                                child: ListView(
                                  controller: scrollController,
                                  children: [
                                    
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          Text(
                                            "${data.title}",
                                            style: TextStyle(
                                                fontFamily: "Rubik",
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: "by",
                                                style: TextStyle(
                                                    fontFamily: "Rubik",
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          " ${data.penyelenggara}",
                                                      style: TextStyle(
                                                          fontFamily: "Rubik",
                                                          fontSize: 15.sp,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal))
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 2.h,
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 233, 228, 228)),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.lock_clock,
                                              color: Colors.orange,
                                              size: 25,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            SizedBox(
                                              width: 90.w,
                                              child: Text(
                                                  "${convert.convert(data.date).substring(0, 11)}\n${convert.convert(data.date).substring(11, 17)} WIB"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_city,
                                              color: Colors.orange,
                                              size: 25,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            SizedBox(
                                              width: 90.w,
                                              child: Text("${data.lokasi}"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Tentang",
                                            style: TextStyle(
                                                fontFamily: "Rubik",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            "${data.deskripsi}",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontFamily: "Rubik",
                                              fontSize: 14.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          }))
                    ],
                  );
          },
        ));
  }

  void _shareText(String text) {
    Share.share(text, subject: 'Sharing via Share Plus');
  }
}
