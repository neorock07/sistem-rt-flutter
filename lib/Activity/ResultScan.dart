import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import 'package:intl/intl.dart';
import "package:sistem_rt/Controller/TextFieldController.dart";
import 'Partials/BtmSheet.dart';

class ResultScan extends StatefulWidget {
  List<String>? text;
  ResultScan({super.key, this.text});

  @override
  State<ResultScan> createState() => _ResultScanState();
}

class _ResultScanState extends State<ResultScan> {
  final _formKey = GlobalKey<FormState>();
  var nikController;
  var namaController;
  var tglController;
  var kelaminController;
  var kawinController;
  var alamatController;
  var kodeController;

  var txtKelaminController = Get.put(RadioButtonPilih());
  var txtKawinController = Get.put(RadioButtonPilih());
  var txtCapitalController = Get.put(CapitalController());
  var txtClearController = Get.put(ClearFieldController());
  var txtSelectDateController = Get.put(SelectTextController());

  var rtController;
  var rwController;
  String? selectedProvince;
  String? selectedKota;
  String? selectedKecamatan;
  String? selectedKelurahan;
  String? rt;
  String? rw;
  var initTime;
  DateTime? selectedDate;

  @override
  void initState() {
    try {
      for (int i = 0; i < widget.text!.length; i++) {
        if (widget.text![i].contains(":")) {
          widget.text![i] = widget.text![i].split(':')[1];
          // selectedProvince = widget.text![11].substring(8);
        }
        log("${widget.text![i]} -> $i");
      }

      //rt dan rw
    } catch (e) {
      log(e.toString());
    }

    rt = widget.text![20].split("/")[0];
    rw = widget.text![20].split("/")[1];
    nikController = TextEditingController(text: widget.text![9]);
    namaController = TextEditingController(text: widget.text![16]);
    alamatController = TextEditingController(text: widget.text![19]);
    rtController = TextEditingController(text: int.parse(rt!).toString());
    rwController = TextEditingController(text: int.parse(rw!).toString());
    kodeController = TextEditingController(text: "57154");
    tglController =
        TextEditingController(text: widget.text![17].split(",")[1].trim());
    kelaminController =
        TextEditingController(text: widget.text![18].substring(0, 1));
    kawinController = (widget.text![24].substring(0, 1) == "B")
        ? TextEditingController(text: "BELUM KAWIN`")
        : TextEditingController(text: "KAWIN");
    initTime = widget.text![17].split(",")[1].trim().split("-");
    selectedProvince = widget.text![11].substring(8);
    selectedKota = widget.text![12].substring(5);
    selectedKecamatan = widget.text![22];
    selectedKelurahan = widget.text![21];
    super.initState();
  }

// nikController =
//     namaController = TextEditingController();
//     tglController = TextEditingController();
//     kelaminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // RowKtp(label: "Negara", input: "INDONESIA"),
    //                 RowKtp(label: "Provinsi", input: "${text![11]}"),
    //                 RowKtp(label: "Kota/Kabupaten", input: "${text![12]}"),
    //                 RowKtp(label: "Kecamatan", input: "${text![22]}"),
    //                 RowKtp(label: "Kelurahan", input: "${text![21].split(':')[1]}"),
    //                 RowKtp(label: "Alamat(RT/RW)", input: "${text![20].split(':')[1]}, ${text![19].split(':')[1]}")

    // nikController.text = widget.text![9];
    // namaController.text = widget.text![16];
    // tglController.text = widget.text![9];
    // kelaminController.text = widget.text![9];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Data",
          style: TextStyle(color: Colors.black, fontFamily: "Rubik"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: (widget.text!.length <= 0)
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                            text: "Periksa ulang data Anda",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik",
                                fontSize: 18.sp),
                            children: [
                              TextSpan(
                                  text:
                                      "\nPastikan data Anda sudah sesuai\nubah jika salah!",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Rubik",
                                      fontSize: 14.sp))
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TxtField(
                              context,
                              label: "NIK",
                              init: widget.text![9],
                              controller: nikController,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Nama Lengkap",
                                init: widget.text![16],
                                controller: namaController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtFieldDate(context,
                                label: "Tanggal Lahir",
                                init: "",
                                controller: tglController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtFieldBtm(context,
                                label: "Jenis Kelamin",
                                value: ["L", "P"],
                                opsi: ["Laki-Laki", "Perempuan"],
                                controllerTxt: txtKelaminController,
                                init: widget.text![18].substring(0),
                                controller: kelaminController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtFieldBtm(context,
                                label: "Status Perkawinan",
                                value: ["BELUM KAWIN", "KAWIN"],
                                opsi: ["BELUM KAWIN", "KAWIN"],
                                controllerTxt: txtKawinController,
                                init: widget.text![24].substring(0),
                                controller: kawinController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Alamat e-KTP",
                                init: widget.text![19],
                                controller: alamatController),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TxtField(context,
                                      label: "RT",
                                      init: "",
                                      keyboardType: TextInputType.number,
                                      controller: rtController),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TxtField(context,
                                      label: "RW",
                                      init: "",
                                      keyboardType: TextInputType.number,
                                      controller: rwController),
                                ),
                              ],
                            ),
                            DropdownField(context,
                                label: "Provinsi",
                                options: [
                                  "Yogya",
                                  "Jawa Barat",
                                  "Jawa Timur",
                                  selectedProvince!
                                ],
                                value: selectedProvince),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownField(context,
                                label: "Kab./Kota",
                                options: [
                                  selectedKota!,
                                  "BOYOLALI",
                                  "SEMARANG",
                                  "SRAGEN"
                                ],
                                value: selectedKota),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownField(context,
                                label: "Kecamatan",
                                options: [
                                  selectedKecamatan!,
                                  "LAWEYAN",
                                  "PASAR KLIWON",
                                  "JEBRES",
                                  "BANJARSARI",
                                ],
                                value: selectedKecamatan),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownField(context,
                                label: "Kelurahan",
                                options: [
                                  selectedKelurahan!,
                                  "LAWEYAN",
                                  "PASAR KLIWON",
                                  "JEBRES",
                                  "BANJARSARI",
                                ],
                                value: selectedKelurahan),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        log("iki log ancuk");

                        // CalendarDatePicker(
                        // initialDate: DateTime(2003, 5, 2),
                        // firstDate: DateTime(1965, 9, 30),
                        // lastDate: DateTime(DateTime.now().year,
                        //       DateTime.now().month, DateTime.now().day),
                        // onDateChanged: (DateTime time){

                        // });
                      },
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
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget RowKtp({String? label, String? input}) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w, left: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 15.sp,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "$input",
            style: TextStyle(
                color: Colors.grey, fontFamily: "Rubik", fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget TxtField(BuildContext context,
      {GlobalKey? key,
      String? label,
      String? init,
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
            textCapitalization: TextCapitalization.characters,
            keyboardType:
                (keyboardType != null) ? keyboardType : TextInputType.text,
            decoration: InputDecoration(
                label: Text("$label"),
                suffixIcon: IconButton(
                    onPressed: () {
                      controller!.text = txtClearController.Clear();
                    },
                    icon: const Icon(Icons.clear, color: Colors.grey))),
          )
        ],
      ),
    );
  }

  Widget DropdownField(BuildContext context,
      {String? label, List<String>? options, String? value}) {
    return DropdownButtonFormField(
        value: value,
        decoration: InputDecoration(label: Text("$label")),
        items: options!.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? str) {
          // setState(() {
          //   print("previous ${this.selectedProvince}");
          //   print("selected $value");
          //   this.selectedProvince = value;
          // });
        });
  }

  Widget TxtFieldBtm(BuildContext context,
      {GlobalKey? key,
      String? label,
      List<dynamic>? value,
      String? init,
      List<dynamic>? opsi,
      TextEditingController? controller,
      dynamic? controllerTxt}) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            // initialValue: init,
            controller: controller,
            readOnly: true,
            onTap: () {
              log("aksi tipu-tipu");
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "$label",
                            style: TextStyle(
                                fontFamily: "Rubik",
                                fontSize: 18.sp,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RadioListTile(
                              title: Text(
                                "${opsi![0]}",
                                style: const TextStyle(
                                  fontFamily: "Rubik",
                                ),
                              ),
                              value: "${value![0]}",
                              groupValue: controllerTxt.text,
                              onChanged: (dynamic msg) {
                                controller!.text =
                                    controllerTxt.UpdateText(msg);
                                Navigator.pop(context);
                              }),
                          RadioListTile(
                              title: Text(
                                "${opsi![1]}",
                                style: const TextStyle(
                                  fontFamily: "Rubik",
                                ),
                              ),
                              value: "${value![1]}",
                              groupValue: controllerTxt.text,
                              onChanged: (dynamic msg) {
                                controller!.text =
                                    controllerTxt.UpdateText(msg);
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    );
                  });
            },
            decoration: InputDecoration(label: Text("$label")),
          )
        ],
      ),
    );
  }

  Widget TxtFieldDate(BuildContext context,
      {GlobalKey? key,
      String? label,
      String? init,
      TextEditingController? controller}) {
    String wkt;
    if (selectedDate != null) {
      wkt = DateFormat("dd-MM-yyyy").format(selectedDate!);
      controller!.text = txtSelectDateController.onChange(wkt);
    }
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            // initialValue: init,
            controller: controller,
            onChanged: (String msg) {
              wkt = DateFormat("dd-MM-yyyy").format(selectedDate!);
              controller!.text = txtSelectDateController.onChange(wkt);
            },
            decoration: InputDecoration(
                label: Text("$label"),
                suffixIcon: IconButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(int.parse(initTime[2]),
                              int.parse(initTime[1]), int.parse(initTime[0])),
                          firstDate: DateTime(1965, 9, 30),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day));
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.grey,
                    ))),
          )
        ],
      ),
    );
  }
}
