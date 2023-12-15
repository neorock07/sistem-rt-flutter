import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sistem_rt/API/Model/RegisterModel/RegisterModel.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_rt/Controller/LoginController/PrefController.dart';

import '../../Utils/Ip.dart';

class RegisterController extends GetxController {
  var ipAdd = Ip();
  var model = RegisterModel().obs;
  // var pref  = Get.put(PrefController());


  Future<RegisterModel?> register(
      {String? kk, String? email, String? password, String? username, String? token}) async {
    try {
      var response = await http.post(
          Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/auth/register"),
          headers: {
            "content-type": "application/json",
             'Authorization': 'Bearer $token'
            },
          body: json.encode({
            "id": kk,
            "email": email,
            "username": username,
            "password": password
          }));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log("msg : ${data['id']} | ${data['username']} | ${data['email']} ");
        return model(RegisterModel.fromJson(data));
      } else {
        Get.snackbar("gagal", "Gagal menambahkan data");
        throw Exception("gagal connect API");
        // return null;
      }
      // return null;
    } catch (e) {
      log("msg error: $e");
    }
  }
}
