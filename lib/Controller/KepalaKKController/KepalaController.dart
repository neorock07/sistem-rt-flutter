import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart';
import 'package:sistem_rt/API/Model/KepalaKelModel/AdminModel.dart';
import 'package:sistem_rt/Controller/RefreshTokenController/RefreshTokenController.dart';

import '../../Utils/Ip.dart';

class KepalaController extends GetxController {
  var ipAdd = Ip();
  List<AdminModel>? data;
  var dataAnggota = <AnggotaModel>[].obs;
  var newToken;
  var tokenBaru;
  var refController = Get.put(RefreshTokenController());
  var raValid = false.obs;

  Future<List<AdminModel?>?> getData(String? token) async {
    var response = await http.get(
      Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/users"),
      headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> raw = json.decode(response.body);
      data = raw.map((e) => AdminModel.fromJson(e)).toList();
      log("data yg diterima : ${data}");
      refController.isTokenValid(token);
      return data;
    } else {
      return null;
      // throw Exception("Could not get data");
    }
  }

  Future<List<AdminModel?>?> getAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? refreshToken = pref.getString("refreshToken");

    if (refController.isTokenValid(token) == true) {
      log("kudu ne valid");
      return getData(token);
      // return data;
    } else {
      raValid.value = true;
      log("nek ra valid kudune iki");
      refController.getRefreshToken(refreshToken!).then((value) {
        token = value!.token;
        refreshToken = value.refreshToken;
        return getData(token);
      });
    }
  }

  
}
