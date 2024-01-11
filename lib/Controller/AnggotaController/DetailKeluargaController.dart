import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart';
import "package:http/http.dart" as http;
import 'package:sistem_rt/Utils/Ip.dart';

class DetailKeluargaController extends GetxController{
    // List<AnggotaModel?>? data;
    var data;
    var model = AnggotaModel().obs;
    var ipAdd = Ip();
    String? kk;

    // DetailKeluargaController({
    //   this.kk
    // });

    // @override
    // void onInit() {
    //   findById(id: kk).then((value) => data);
    //   super.onInit();
    // }

    Future<List<AnggotaModel?>?> findById({String? id}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      String? refreshToken = pref.getString("refreshToken");
      log("id yang dipost : $id");
      var response = await http.get(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/keluarga/${id}"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      log("data yg diterima : ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        Map<String, dynamic> map_data = json.decode(response.body); 
        List<dynamic> data_list = map_data["anggota"];
        data =
            data_list.map((e) => AnggotaModel.fromJson(e)).toList();
        log("data anggota yg diterima : ${data[0].nama}");    
        return data;
      } else {
        Get.snackbar("Gagal memuat", "Gagal memuat data");
        return data;
      }
    } catch (e) {
      Get.snackbar("Pesan", "Tidak ada data");
      throw Exception("error get data");
    }
  }
}