import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/API/Model/KeuanganModel/KeuanganModel.dart';
import 'package:sistem_rt/Activity/AddKeuangan.dart';
import 'package:sistem_rt/Controller/KeuanganController/KeuanganController.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class KeuanganView extends StatefulWidget {
  const KeuanganView({Key? key}) : super(key: key);

  @override
  _KeuanganViewState createState() => _KeuanganViewState();
}

class _KeuanganViewState extends State<KeuanganView> {
  var outcome = 0.obs;
  var income = 0.obs;
  var controller = Get.put(KeuanganController());
  NumberFormat formatter = NumberFormat("#,###", "id_ID");

  String? role;

  Future<void> shared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    role = pref.getString("role")!;
    setState(() {
      log("iki role : $role");  
    });
    // return ref;
  }

  @override
  void initState() {
    super.initState();
    shared();

    // user = pref.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (role == "SUPERADMIN")? FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
              return AddKeuangan();
          }));
        },
        backgroundColor:const Color.fromRGBO(23, 78, 171, 1.0) ,
        child: Icon(Icons.add, color: Colors.white, size: 25,),
      ) : null,
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
        title: const Text(
          "Keuangan RT",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 3.dm),
                    borderRadius: BorderRadius.circular(10.dm)),
                child: Padding(
                  padding: EdgeInsets.all(10.dm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<KeuanganController>(
                        init: KeuanganController(),
                        initState: (_) async {
                          await controller.getSumNominal(1).then((value) {
                            income.value = value;
                          });
                        },
                        builder: (_) {
                          return Column(
                            children: [
                              Obx(() => Text(
                                    "Rp.${formatter.format(income.value)}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: "Rubik",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                "Pemasukan",
                                style: TextStyle(
                                    fontFamily: "Rubik",
                                    fontSize: 16.sp,
                                    color: Colors.grey),
                              )
                            ],
                          );
                        },
                      ),
                      Container(
                        height: 80.h,
                        width: 2.w,
                        color: Colors.black,
                      ),
                      GetBuilder<KeuanganController>(
                        init: KeuanganController(),
                        initState: (_) async {
                          await controller.getSumNominal(2).then((value) {
                            outcome.value = value;
                          });
                        },
                        builder: (_) {
                          return Column(
                            children: [
                              Obx(() => Text(
                                    "Rp.${formatter.format(outcome.value)}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Rubik",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                "Pengeluaran",
                                style: TextStyle(
                                    fontFamily: "Rubik",
                                    fontSize: 16.sp,
                                    color: Colors.grey),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
                child: Obx(() => SingleChildScrollView(
                      controller: scrollController,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Nominal')),
                          DataColumn(label: Text('Date')),
                        ],
                        rows: controller.data_keu.value.map((row) {
                          return DataRow(
                            cells: [
                              DataCell(Text(row['id'].toString())),
                              DataCell(Text(
                                "Rp.${formatter.format(int.parse(row['nominal'].toString()))}",
                                style: TextStyle(
                                    color: (controller.data_income.contains(
                                            int.parse(row['id'].toString())))
                                        ? Colors.green
                                        : Colors.red,
                                        fontWeight: FontWeight.bold
                                        ),
                              )),
                              DataCell(Text(row['date'] != null
                                  ? DateTime.fromMillisecondsSinceEpoch(
                                          row['date'])
                                      .toString().substring(0,10)
                                  : 'null')),
                            ],
                          );
                        }).toList(),
                      ),
                    )),
              );
            }))
      ]),
    );
  }
}
