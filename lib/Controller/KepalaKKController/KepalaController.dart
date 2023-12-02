import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_rt/API/Model/KepalaKelModel/AdminModel.dart';

import '../../Utils/Ip.dart';

class KepalaController extends GetxController {
  var ipAdd = Ip();
  var data = <AdminModel>[].obs;
  var newToken;
  var tokenBaru;

  // dynamic getData(String? token) async {
  //   var response =  await http.get(
  //     Uri.parse("https://${ipAdd.getIp()}/api/v1/users"),
  //     headers: {
  //       "content-type": "application/json",
  //       'Authorization': 'Bearer $token'
  //     },
  //   );
  //   return response;
  // }


  Future<List<AdminModel?>> getAll() async {
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? refreshToken = pref.getString("refreshToken");
    
    var response =  await http.get(
      Uri.parse("https://${ipAdd.getIp()}/api/v1/users"),
      headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> raw = json.decode(response.body);
      data.value = raw.map((e) => AdminModel.fromJson(e)).toList();
      log("data yg diterima : ${data.value}");
      return data;
    }else if(response.statusCode == 403){
      newToken = await http.post(
      Uri.parse("https://${ipAdd.getIp()}/api/v1/refresh"),
      headers: {
        "content-type": "application/json"
      },
      body: {
        "token": '$refreshToken'
      }
    );

      if(newToken.statusCode == 200){
        var baru = json.decode(newToken.body);
        var tokenBaru = baru['token'];
        token = tokenBaru;
        log("lewat kene ra");
        response  =  await http.get(
      Uri.parse("https://${ipAdd.getIp()}/api/v1/users"),
      headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

      }else{
        throw Exception("gagal refresh token");
      }
      return data;
    }
     else {
      throw Exception("Could not get data");
    }
  }

  




}
