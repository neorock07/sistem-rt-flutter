import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sistem_rt/Activity/Partials/TxtField.dart';
import 'package:sistem_rt/Controller/EventController/EventController.dart';
import 'package:sistem_rt/Controller/TextFieldController.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var lokasiController = TextEditingController();
  var deskripsiController = TextEditingController();
  var vendorController = TextEditingController();
  var tanggalController = TextEditingController();
  var jamController = TextEditingController();
  var menitController = TextEditingController();
  var txtSelectDateController = Get.put(SelectTextController());
  var saveController = Get.put(EventController());

  DateTime? selectedDate;
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Tambah Event",
          style: TextStyle(fontFamily: "Rubik", color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      getImageFromGallery();
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            // color: Colors.grey,
                            border: Border.all(
                                style: BorderStyle.solid,
                                color:
                                    const Color.fromARGB(255, 199, 198, 198))),
                        child: (_image == null)
                            ? const Icon(Icons.upload_file,
                                size: 50, color: Colors.grey)
                            : Image.file(_image!)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Thumbnail Event",
                    style: TextStyle(fontFamily: "Rubik", color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
              child: TxtField(context,
                  key: _formKey,
                  label: "Judul Acara",
                  controller: titleController),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
              child: TxtField(context,
                  key: _formKey, label: "Lokasi", controller: lokasiController),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
              child: TxtField(context,
                  key: _formKey,
                  label: "Penyelenggara",
                  controller: vendorController),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 180.w,
                    child: TxtFieldDate(context,
                        key: _formKey,
                        label: "Tanggal",
                        controller: tanggalController),
                  ),
                  SizedBox(
                    width: 60.w,
                    child: TxtField(context,
                        key: _formKey,
                        label: "Jam",
                        keyboardType: TextInputType.datetime,
                        controller: jamController),
                  ),
                  Text(":"),
                  SizedBox(
                    width: 60.w,
                    child: TxtField(context,
                        key: _formKey,
                        label: "Menit",
                        keyboardType: TextInputType.datetime,
                        controller: menitController),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
              child: TxtField(context,
                  key: _formKey,
                  keyboardType: TextInputType.multiline,
                  maxline: 4,
                  label: "Deskripsi",
                  controller: deskripsiController),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              splashColor: Colors.blueAccent,
              onTap: () async {
                log("${tanggalController.text}T${jamController.text}:${menitController.text}:00.000Z");
                var waktu =
                    "${tanggalController.text}T${jamController.text}:${menitController.text}:00.000Z";

                if (_image != null ||
                    titleController.text.isNotEmpty ||
                    lokasiController.text.isNotEmpty ||
                    vendorController.text.isNotEmpty) {
                  await saveController.save(
                      _image!,
                      titleController.text,
                      deskripsiController.text,
                      lokasiController.text,
                      waktu,
                      vendorController.text);
                }else{
                  Get.snackbar("Kesalahan Pengisian", "Isi data dengan benar");
                }
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
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Widget TxtFieldDate(BuildContext context,
      {GlobalKey? key,
      String? label,
      String? init,
      TextEditingController? controller}) {
    String wkt;
    if (selectedDate != null) {
      wkt = DateFormat("yyyy-MM-dd").format(selectedDate!);
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
              wkt = DateFormat("yyyy-MM-dd").format(selectedDate!);
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
