import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sistem_rt/API/Model/EventModel/EventModel.';
import 'package:sistem_rt/Activity/DetailEvent.dart';
import 'package:sistem_rt/Controller/EventController/EventController.dart';
import 'package:sistem_rt/Controller/SearchController/SearchController.dart';
import 'package:sistem_rt/Utils/Ip.dart';

import '../Utils/convertTime.dart';

class EventView extends StatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  var ipAdd = Ip();
  var controller = Get.put(EventController());
  var SearchController = TextEditingController();
  var bongkar = Get.put(BongkarController());
  List<EventModel?>? list_event_new = [];

  // String link =
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtC_jDGW6CDoB6_COVdWKSXRH9DMcw9Vuwhg&usqp=CAU";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
          onPressed: (){},
          splashColor: Colors.blueAccent,
          child: const Icon(Icons.add, size: 30,color:Colors.white,),
          ),
        appBar: AppBar(
          title: const Align(alignment: Alignment.topLeft, child: Text("Event")),
          toolbarHeight: 80.h,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: AnimSearchBar(
                width: MediaQuery.of(context).size.width * 0.7,
                textController: SearchController,
                onSuffixTap: () {},
                onSubmitted: (String st) {
                  list_event_new = bongkar.CariEvent(
                      st, controller.data.value.cast<EventModel>());
                },
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        // body: (controller.data.value.isEmpty)
        // ? const Center(child: CircularProgressIndicator())
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
              child: Obx(() => GridView.builder(
                  itemCount: (list_event_new!.isNotEmpty)
                      ? list_event_new!.length
                      : controller.data.value.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 220.dm),
                  itemBuilder: (context, index) => ContainerEvent(
                        id: (list_event_new!.isNotEmpty)
                            ? list_event_new![index]!.id
                            : controller.data.value[index].id!,
                        link: (list_event_new!.isNotEmpty)
                            ? "${ipAdd.getType()}://${ipAdd.getIp()}${list_event_new![index]!.fileUrl!.substring(24)}"
                            : "${ipAdd.getType()}://${ipAdd.getIp()}${controller.data.value[index].fileUrl!.substring(24)}",
                        lokasi: (list_event_new!.isNotEmpty)
                            ? list_event_new![index]!.lokasi
                            : controller.data.value[index].lokasi!,
                        tanggal: (list_event_new!.isNotEmpty)
                            ? list_event_new![index]!.date
                            : controller.data.value[index].date!,
                        title: (list_event_new!.isNotEmpty)
                            ? list_event_new![index]!.title
                            : controller.data.value[index].title!,
                      ))),
            ),
          ],
        ));
  }
}

class ContainerEvent extends StatelessWidget {
  ContainerEvent(
      {super.key,
      required this.id,
      required this.link,
      required this.title,
      required this.lokasi,
      required this.tanggal});
  var convert = convertTime();

  final String id;
  final String link;
  final String title;
  final String lokasi;
  final dynamic tanggal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.dm)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey,
          hoverColor: Colors.grey,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailEvent(
                          id: id,
                        )));
          },
          child: Stack(
            children: [
              Container(
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.dm),
                    image: DecorationImage(
                        image: NetworkImage(link), fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 90.h, left: 10.w, right: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        (title.length < 25)
                            ? title
                            : "${title.substring(0, 25)}...",
                        style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          size: 15,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("$lokasi", style: TextStyle(fontFamily: "Rubik"))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 15,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("${convert.convert(tanggal).substring(0, 11)}",
                            style: TextStyle(fontFamily: "Rubik")),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.lock_clock,
                          size: 15,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("${convert.convert(tanggal).substring(11, 17)}",
                            style: TextStyle(fontFamily: "Rubik")),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
