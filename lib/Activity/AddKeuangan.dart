import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:sistem_rt/Activity/KeuanganView.dart';
import 'package:sistem_rt/Controller/KeuanganController/KeuanganController.dart';
import 'package:sistem_rt/Utils/convertTime.dart';

class AddKeuangan extends StatefulWidget {
  const AddKeuangan({Key? key}) : super(key: key);

  @override
  _AddKeuanganState createState() => _AddKeuanganState();
}

class _AddKeuanganState extends State<AddKeuangan> {
  var isSelected = true.obs;
  var controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  DateTime? selectedDate;
  String? waktu;
  DateTime today = DateTime.now();
  var convert = convertTime();
  String? formattedDate;
  var saveController = Get.put(KeuanganController());

  @override
  void initState() {
    super.initState();
    formattedDate =
        "${today.year}-${convert.addLeadingZero(today.month)}-${convert.addLeadingZero(today.day)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
        title: Text(
          "Tambah Keuangan",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Tanggal",
                style:
                    TextStyle(fontFamily: "Rubik", fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 30.w,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () async {
                    selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1965, 9, 30),
                        lastDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day));
                    setState(() {
                      waktu = DateFormat("yyyy-MM-dd").format(selectedDate!);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(255, 208, 207, 207)),
                        borderRadius: BorderRadius.circular(10.dm)),
                    child: Padding(
                      padding: EdgeInsets.all(5.dm),
                      child: (waktu == null)
                          ? Text("${formattedDate}")
                          : Text("${waktu}"),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.dm)),
            child: Padding(
              padding: EdgeInsets.all(10.dm),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Pilih Kategori",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ChoiceChip(
                              selectedColor: Colors.green,
                              disabledColor: Colors.grey,
                              onSelected: (bool st) {
                                isSelected.value = true;
                                log("${isSelected.value}");
                              },
                              label: const Text(
                                "Pemasukan",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.bold),
                              ),
                              selected:
                                  (isSelected.value == true) ? true : false),
                          ChoiceChip(
                              selectedColor: Colors.red,
                              disabledColor: Colors.grey,
                              onSelected: (bool st) {
                                isSelected.value = false;
                                log("${isSelected.value}");
                              },
                              label: const Text(
                                "Pengeluaran",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.bold),
                              ),
                              selected:
                                  (isSelected.value == false) ? true : false),
                        ],
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.dm)),
            child: Padding(
              padding: EdgeInsets.all(10.dm),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nominal (Rp)",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    autofocus: true,
                    controller: controller,
                    style: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    inputFormatters: [
                      NumberTextInputFormatter(
                        integerDigits: 10,
                        decimalDigits: 0,
                        maxValue: '1000000000.00',
                        // decimalSeparator: '.',
                        groupDigits: 3,
                        groupSeparator: ',',
                        allowNegative: false,
                        overrideDecimalPoint: true,
                        insertDecimalPoint: false,
                        insertDecimalDigits: true,
                      ),
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.dm))),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            splashColor: Colors.blueAccent,
            onTap: () {
              int nom = int.parse(controller.text.toString().replaceAll(',', ''));
              log("nilai angka : ${int.parse(controller.text.toString().replaceAll(',', ''))}");
              saveController.save(nom, (waktu == null)
                          ? formattedDate
                          : waktu,
                           (isSelected.value == false) ? 2 : 1).then((value){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                                return KeuanganView();
                              }));
                              Get.snackbar((value == true)? "Berhasil Menyimpan" : "Gagal",
                              (value == true)? "Data berhasil disimpan" : "Gagal menyimpan");
                           });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.dm)),
              child: Padding(
                  padding: EdgeInsets.all(10.dm),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(23, 78, 171, 1.0),
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Center(
                      child: Text(
                        "Simpan data",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Rubik",
                            fontSize: 18.sp),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
