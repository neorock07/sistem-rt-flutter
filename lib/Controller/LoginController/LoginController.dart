import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_rt/Activity/Login.dart';
import 'package:sistem_rt/Controller/LoginController/PrefController.dart';
import '../../API/Model/LoginModel/LoginModel.dart';
import '../../Utils/Ip.dart';

class LoginController extends GetxController {
  var model = LoginModel().obs;
  var prefController = Get.put(PrefController());
  var isLoad = false.obs;
  Map<String, dynamic> data = {};

  Future<LoginModel?> fetch({String? email, String? password}) async {
    // isLoad(true);
    try {
      var ipAdd = Ip();
      var response = await http.post(
          Uri.parse("${ipAdd.type}://${ipAdd.ip}/api/v1/auth/login"),
          headers: {"content-type": "application/json"},
          body: json.encode({"email": email, "password": password}));
      if (response.statusCode == 200) {
        isLoad.value = false;
        data = json.decode(response.body);
        prefController.saveData(
          email: data['email'],
          password: data['password'],
          role: data['role'],
          token: data['token'],
          refreshToken: data['refreshToken'],
        );
        log("msg : ${data['email']} | ${data['role']} | ${data['token']}");
        log("pref : ${prefController.getEmail()} | ${prefController.getToken()}");
        Get.snackbar("Sukses", "Login berhasil");

        return model(LoginModel.fromJson(data));
      } else {
        throw Exception("Gagal mengambil data");
        // return null;
      }
    } catch (e) {
      Get.snackbar("Error", "Login gagal");
      log("msg : ${model.value.email} | ${model.value.token}");
      log("gagal mengambil data");
      Get.to(() => Login());
    }
  }
}
