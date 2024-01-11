// ignore_for_file: invalid_use_of_protected_member
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart';
import 'package:sistem_rt/Activity/Partials/BaseCard.dart';
import 'package:sistem_rt/Controller/AnggotaController/DetailKeluargaController.dart';
import 'package:sistem_rt/Controller/KepalaKKController/KepalaController.dart';
import 'package:sistem_rt/Utils/convertTime.dart';

class DetailKeluarga extends StatefulWidget {
  // dynamic dataModel;
  String? kk;
  DetailKeluarga({super.key, this.kk});

  @override
  State<DetailKeluarga> createState() => _DetailKeluargaState();
}

class _DetailKeluargaState extends State<DetailKeluarga> {
  var detailController = Get.put(DetailKeluargaController());
  var coeg = [].obs;
  var convert = convertTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
          title: Obx(() => Text((coeg.value.isEmpty)
              ? "${widget.kk}"
              : coeg.value[0]!.nama.toString())),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "rubik",
            fontSize: 18.sp,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Align(
            alignment: Alignment.topCenter,
            child: GetBuilder<DetailKeluargaController>(
                initState: (state) {
                  DetailKeluargaController()
                      .findById(id: widget.kk)
                      .then((value) {
                    coeg.value = value!;
                  });
                },
                init: DetailKeluargaController(),
                builder: (snap) {
                  return Obx(() {
                    return (coeg.value.isEmpty)
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              Text(
                                "Tidak Ada Data",
                                style: TextStyle(
                                    fontFamily: "rubik", fontSize: 18.sp),
                              )
                            ],
                          ))
                        : Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              BaseCard(
                                  context,
                                  [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Nama",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          coeg.value[0]!.nama.toString(),
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Tempat/Tgl Lahir",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(
                                        //   () =>
                                        // )
                                        Text(
                                          "${coeg.value[0]!.kota.toString()}/${convert.convert(coeg.value[0]!.tgl_lahir).substring(0, 10)}",
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Jenis Kelamin",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          (coeg.value[0]!.jenis_kelamin
                                                      .toString() ==
                                                  "L")
                                              ? "Laki-Laki"
                                              : "Perempuan",
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Perkawinan",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          "${coeg.value[0]!.id}",
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Pekerjaan",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          "${coeg.value[0]!.pekerjaan}",
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Provinsi",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          "${coeg.value[0]!.prov}",
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Kota",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          "${coeg.value[0]!.kota}",
                                          style: const TextStyle(
                                              fontFamily: "Rubik"),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Alamat",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.grey),
                                        ),
                                        // Obx(() =>
                                        //     ),
                                        Text(
                                          "${coeg.value[0]!.alamat}, ${coeg.value[0]!.kecamatan}",
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              fontSize: 10.sp),
                                        )
                                      ],
                                    ),
                                  ],
                                  Colors.transparent),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: ExpansionTile(
                                  shape: Border.all(
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside),
                                  backgroundColor:
                                      const Color.fromARGB(255, 232, 232, 232),
                                  title: Text(
                                    "Orang yang berkaitan dengan ${coeg.value[0]!.nama.toString()}",
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  children: [
                                    Stack(children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: ListView.builder(
                                            itemCount: coeg.value.length - 1,
                                            itemBuilder: ((context, index) {
                                              int i = index + 1;
                                              if (i >= coeg.value.length) {
                                                i = index;
                                              }
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.dm, right: 10.dm),
                                                child: DetailCard(context,
                                                    index: i),
                                              );
                                            })),
                                      ),
                                    ])
                                  ],
                                ),
                              )
                            ],
                          );
                  });
                }))
        // : CircularProgressIndicator()
        );
  }

  Widget DetailCard(BuildContext context, {int? index}) {
    return BaseCard(
        context,
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Nama",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                coeg.value[index!]!.nama.toString(),
                style: const TextStyle(fontFamily: "Rubik"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tempat/Tgl Lahir",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(
              //   () =>
              // )
              Text(
                "${coeg.value[index!]!.kota.toString()}/${convert.convert(coeg.value[0]!.tgl_lahir).substring(0, 10)}",
                style: const TextStyle(fontFamily: "Rubik"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Jenis Kelamin",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                (coeg.value[index!]!.jenis_kelamin.toString() == "L")
                    ? "Laki-Laki"
                    : "Perempuan",
                style: const TextStyle(fontFamily: "Rubik"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Perkawinan",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                "${coeg.value[index!]!.id}",
                style: const TextStyle(fontFamily: "Rubik"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pekerjaan",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                "${coeg.value[index!]!.pekerjaan}",
                style: const TextStyle(fontFamily: "Rubik"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Provinsi",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                "${coeg.value[index!]!.prov}",
                style: const TextStyle(fontFamily: "Rubik"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kota",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                "${coeg.value[index!]!.kota}",
                style: const TextStyle(fontFamily: "Rubik"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Alamat",
                style: TextStyle(fontFamily: "Rubik", color: Colors.grey),
              ),
              // Obx(() =>
              //     ),
              Text(
                "${coeg.value[index!]!.alamat}, ${coeg.value[index!]!.kecamatan}",
                style: TextStyle(fontFamily: "Rubik", fontSize: 10.sp),
              )
            ],
          ),
        ],
        Colors.transparent);
  }
}
