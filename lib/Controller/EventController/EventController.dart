import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sistem_rt/Utils/Ip.dart';

import '../../API/Model/EventModel/EventModel.';
import 'package:http/http.dart' as http;

class EventController extends GetxController {
  var ipAdd = Ip();
  var data = [].obs;
  Map<String, dynamic> dataDetail = {};

  @override
  void onInit() async {
    await getAllData();
    super.onInit();
  }

  Future<dynamic> getAllData({
    int page = 0,
    int size = 10
  }) async {

      try {
      var response = await http.get(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/events?page=$page&size=$size"),
        headers: {
          "content-type": "application/json",
        },
      );
      log("data yg diterima : ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        List<dynamic> data_list = json.decode(response.body);
        data.value =
            data_list.map((e) => EventModel.fromJson(e)).toList();
        log("data anggota yg diterima : ${data[0].filename}");    
        return data.value;
      } else {
        Get.snackbar("Gagal memuat", "Gagal memuat data");
        return data.value;
      }
    } catch (e) {
      Get.snackbar("Pesan", "Tidak ada data");
      throw Exception("error get data");
    } 
  }

  Future<EventModel> findById(String id) async {
    try {
      var response = await http.get(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/events/content/$id"),
        headers: {
          "content-type": "application/json",
        },
      );
      log("data yg diterima : ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        // List<dynamic> data_list = json.decode(response.body);
        dataDetail = json.decode(response.body);
            
        log("data anggota yg diterima : ${dataDetail['filename']}");    
        return EventModel.fromJson(dataDetail);
      } else {
        Get.snackbar("Gagal memuat", "Gagal memuat data");
        throw Exception("error get data");
      }
    } catch (e) {
      Get.snackbar("Pesan", "Tidak ada data");
      throw Exception("error get data");
    } 
  }

}