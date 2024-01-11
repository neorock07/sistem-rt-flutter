import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart';
import 'package:sistem_rt/Activity/KeluargaView.dart';
import 'package:sistem_rt/Controller/AnggotaController/DataDiriController.dart';
import 'package:sistem_rt/Controller/DataWilayah/WilayahController.dart';
import 'package:sistem_rt/Controller/LoginController/PrefController.dart';
import 'package:sistem_rt/Controller/TextFieldController.dart';

class AddManual extends StatefulWidget {
  const AddManual({Key? key}) : super(key: key);

  @override
  _AddManualState createState() => _AddManualState();
}

class _AddManualState extends State<AddManual> {
  final _formKey = GlobalKey<FormState>();
  var nikController = TextEditingController();
  var namaController = TextEditingController();
  var tglController = TextEditingController();
  var kelaminController = TextEditingController();
  var kawinController = TextEditingController();
  var alamatController = TextEditingController();
  var kodeController = TextEditingController();
  var provController = TextEditingController();
  var kotaController = TextEditingController();
  var kecamatanController = TextEditingController();
  var kelurahanController = TextEditingController();
  var kkController = TextEditingController();
  var hpController = TextEditingController();

  var txtKelaminController = Get.put(RadioButtonPilih());
  var txtKawinController = Get.put(RadioButtonPilih());
  var txtCapitalController = Get.put(CapitalController());
  var txtClearController = Get.put(ClearFieldController());
  var txtSelectDateController = Get.put(SelectTextController());
  var simpanController = Get.put(DataDiriController());
  var prefController = Get.put(PrefController());
  var wilayahController = Get.put(WilayahController());

  var rtController = TextEditingController();
  var rwController = TextEditingController();
  String? selectedProvince;
  String? selectedKota;
  String? selectedKecamatan;
  String? selectedKelurahan;
  var selectedPekerjaan = TextEditingController(text: "PILIH");
  String? rt;
  String? rw;
  var initTime;
  DateTime? selectedDate;
  bool isNull = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Data",
          style: TextStyle(color: Colors.black, fontFamily: "Rubik"),
        ),
      ),
      body: (isNull == true)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text("Data tidak terambil dengan jelas!")),
                Center(
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Scan lagi")))
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                            text: "Isi data",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik",
                                fontSize: 18.sp),
                            children: [
                              TextSpan(
                                  text: "\nPastikan data Anda sudah sesuai!",
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
                              label: "KK",
                              controller: kkController,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(
                              context,
                              label: "NIK",
                              // init: widget.text![9],
                              controller: nikController,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Nama Lengkap",
                                // init: widget.text![16],
                                controller: namaController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "No.Hp",
                                keyboardType: TextInputType.phone,
                                controller: hpController),
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
                                // init: widget.text![18].substring(0),
                                controller: kelaminController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtFieldBtm(context,
                                label: "Status Perkawinan",
                                value: ["BELUM KAWIN", "KAWIN"],
                                opsi: ["BELUM KAWIN", "KAWIN"],
                                controllerTxt: txtKawinController,
                                // init: widget.text![24].substring(0),
                                controller: kawinController),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownField(context,
                                label: "Pekerjaan",
                                options: [
                                  "PILIH",
                                  "PELAJAR",
                                  "BURUH",
                                  "KARYAWAN SWASTA",
                                  "PNS",
                                  "WIRASWASTA",
                                ],
                                value: selectedPekerjaan),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Alamat e-KTP",
                                // init: widget.text![19],
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
                            TxtField(context,
                                label: "Provinsi",
                                // init: selectedProvince!,
                                keyboardType: TextInputType.streetAddress,
                                controller: provController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Kab./Kota",
                                keyboardType: TextInputType.streetAddress,
                                init: selectedKota,
                                controller: kotaController),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Kecamatan",
                                init: selectedKecamatan,
                                controller: kecamatanController,
                                keyboardType: TextInputType.streetAddress),
                            SizedBox(
                              height: 5.h,
                            ),
                            TxtField(context,
                                label: "Kelurahan",
                                init: selectedKelurahan,
                                controller: kelurahanController,
                                keyboardType: TextInputType.streetAddress),
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
                      child: FutureBuilder(
                          future: prefController.getToken(),
                          builder: (_, snap) => (snap.connectionState ==
                                  ConnectionState.done)
                              ? Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      var formatted =
                                          "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
                                      DateTime tm = DateTime.parse(formatted);
                                      var unix = tm.millisecondsSinceEpoch;

                                      log("iki lo ${nikController.text}");
                                      log("iki kk ${kkController.text}");
                                      log("iki kk ${formatted}");
                                      log("iki kk ${kelaminController.text}");
                                      log("iki kk ${selectedPekerjaan.text}");
                                      simpanController
                                          .insert(
                                              model: AnggotaModel(
                                                id: nikController.text,
                                                nama: namaController.text,
                                                no_telp: hpController.text,
                                                tgl_lahir: unix,
                                                tempat_lahir:
                                                    kotaController.text,
                                                jenis_kelamin:
                                                    kelaminController.text,
                                                pekerjaan:
                                                    selectedPekerjaan.text,
                                                isKawin: txtKawinController
                                                    .text.value,
                                                bangsa: 'WNI',
                                                negara: "Indonesia",
                                                prov: provController.text,
                                                kota: kotaController.text,
                                                kecamatan:
                                                    kecamatanController.text,
                                                alamat:
                                                    "${alamatController.text},Rt ${rtController.text}/Rw ${rwController.text}",
                                              ),
                                              kk: kkController.text,
                                              token: snap.data)
                                          .then((value) {
                                        (selectedPekerjaan.text == "PILIH")
                                            ? showDialog(
                                                context: context,
                                                builder: (snap) =>
                                                    const AlertDialog(
                                                  title: Text("Kesalahan"),
                                                  actions: [
                                                    Center(
                                                        child: Text(
                                                            "Pekerjaan tidak valid"))
                                                  ],
                                                ),
                                              )
                                            : (simpanController.isOk.value ==
                                                        true ||
                                                    simpanController
                                                            .status.value ==
                                                        200)
                                                ? Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            KeluargaView()))
                                                : showDialog(
                                                    context: context,
                                                    builder: (snap) =>
                                                        const AlertDialog(
                                                      title: Text("Kesalahan"),
                                                      actions: [
                                                        Center(
                                                            child: Text(
                                                                "No. KK tidak terdaftar"))
                                                      ],
                                                    ),
                                                  );
                                        simpanController.isOk.value = false;
                                      });
                                    },
                                    child:
                                        (simpanController.isOk.value == false)
                                            ? Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        23, 78, 171, 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.h)),
                                                child: Center(
                                                  child: Text(
                                                    "Simpan data",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Rubik",
                                                        fontSize: 18.sp),
                                                  ),
                                                ),
                                              )
                                            : const CircularProgressIndicator(),
                                  ),
                                )
                              : const CircularProgressIndicator()),
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
      {String? label, List<String>? options, TextEditingController? value}) {
    return DropdownButtonFormField(
        value: value!.text,
        decoration: InputDecoration(label: Text("$label")),
        items: options!.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? str) {
          setState(() {
            value.text = str!;
          });

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
            readOnly: true,
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
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1965, 9, 30),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day));
                      setState(() {});
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
