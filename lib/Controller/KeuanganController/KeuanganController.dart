import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/API/Model/KategoriModel/KategoriModel.dart';
import 'package:sistem_rt/API/Model/KeuanganModel/KeuanganModel.dart';
import 'package:sistem_rt/Controller/RefreshTokenController/RefreshTokenController.dart';
import 'package:http/http.dart' as http;
import '../../Utils/Ip.dart';

class KeuanganController extends GetxController {
  var ipAdd = Ip();
  var isOk = false.obs;
  var status = 0.obs;
  Map<String, KeuanganModel>? data;
  var refController = Get.put(RefreshTokenController());
  var data_list = <dynamic>[].obs;
  var data_income = [].obs;
  var data_outcome = [].obs;
  var data_keu = [].obs;

  @override
  void onInit() {
    getNewToken();
    getAllKeu();
    getAll();
    // findById(2);
    super.onInit();
  }

  Future<void> getNewToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? refreshToken = pref.getString("refreshToken");

    if (refController.isTokenValid(token) == true) {
      log("kudu ne valid");
      // return data;
    } else {
      log("nek ra valid kudune iki");
      await refController.getRefreshToken(refreshToken!).then((value) {
        token = value!.token;
        refreshToken = value.refreshToken;
      });
      Get.snackbar("Get New Token", "Mendapatkan token");
    }
  }

  Future<bool> save(int? nominal, String? waktu, int? kategori) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    Map<String, dynamic> dt = {
      "nominal": nominal,
      "date": waktu,
      "kategori_id": {"id": kategori}
    };
    var response = await http.post(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/keuangan"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(dt));
    log("pesan : ${response.statusCode.toString()}");
    if (response.statusCode == 200) {
      isOk.value = true;
      status.value = 200;
      return true;
    } else {
      isOk.value = false;
      status.value = response.statusCode;
      return false;
    }
  }

  Future<KeuanganModel> findById(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    var response = await http.get(
      Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/keuangan/$id"),
      headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      log("iki diterima : ${map}");
      return KeuanganModel.fromJson(map);

    } else {
      throw Exception("Gagal");
    }
  }

  Future<List<dynamic>> getAll() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      String? refreshToken = pref.getString("refreshToken");
      // log("id yang dipost : $id");
      var response = await http.get(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/kategori"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      log("kategori : ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        // Map<String, dynamic> map_data = json.decode(response.body);
        data_list.value = json.decode(response.body);
        // dataAll =
        //     data_list.map((e) => KategoriModel.fromJson(e)).toList();
        log("data kategori yg diterima : ${data_list.value}");
        data_income.value = data_list.value[0]['keuangan'];
        data_outcome.value = data_list.value[1]['keuangan'];
        log("income : ${data_list.value[0]['keuangan']}");
        return data_list.value!;
      } else {
        Get.snackbar("Gagal memuat", "Gagal memuat data");
        return data_list.value!;
      }
    } catch (e) {
      Get.snackbar("Pesan", "Tidak ada data");
      throw Exception("error get data");
    }
  }
  Future<List<dynamic>> getAllKeu() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      String? refreshToken = pref.getString("refreshToken");
      // log("id yang dipost : $id");
      var response = await http.get(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/keuangan"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      log("data keuangan diterima : ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        // Map<String, dynamic> map_data = json.decode(response.body);
        data_keu.value = json.decode(response.body);
        // dataAll =
        //     data_list.map((e) => KategoriModel.fromJson(e)).toList();
        log("data keuangan yg diterima : ${data_keu.value}");
        return data_keu.value;
      } else {
        Get.snackbar("Gagal memuat", "Gagal memuat data ${response.statusCode}");
        return data_keu.value;
      }
    } catch (e) {
      Get.snackbar("Pesan", "Tidak ada data ");
      throw Exception("error get data");
    }
  }

  Future<int> getSumNominal(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    var response = await http.get(
      Uri.parse(
          "${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/keuangan/sum/$id"),
      headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      int sumData = json.decode(response.body);
      return sumData;
    } else {
      throw Exception("Kesalahan");
    }
  }
}
