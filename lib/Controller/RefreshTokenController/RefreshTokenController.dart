import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:sistem_rt/Utils/Ip.dart';

import '../../API/Model/RefreshTokenModel/RefreshTokenModel.dart';
import '../LoginController/PrefController.dart';

class RefreshTokenController extends GetxController {
  var prefController = Get.put(PrefController());

  /*
    function untuk get exp dari token
  */

  Map<dynamic, dynamic>? parseJwt(String token) {
    try {
      final part = token.split(".");
      String payload = part[1];
      if (part.length != 3) {
        return null;
      }

      final String decoded =
          utf8.decode(base64Url.decode(base64Url.normalize(payload)));

      return json.decode(decoded);
    } catch (e) {
      log("error : $e");
    }
  }

  bool isTokenValid(String? token) {
    Map<dynamic, dynamic> jwtPayload = parseJwt(token!)!;

    /*
      cek expired jwt
    */
    int currTime = int.parse(DateTime.now().microsecondsSinceEpoch.toString().substring(0, 10));
    int expTime = jwtPayload['exp'];
    log("iki lo currTime : ${currTime} | exp : ${expTime}");

    return (currTime > expTime) ? false : true;
  }

  Future<RefreshTokenModel?> getRefreshToken(String token) async {
    try {
      var ipAdd = Ip();
      final response = await http.post(
          Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/auth/refresh"),
          headers: {"content-type": "application/json"},
          body: json.encode({"token": token}));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        prefController.saveNewToken(
          token: data['token'],
          refreshToken: data['refreshToken'],
        );
        log("yg baru ini : ${data['token']} | ${data['refreshToken']}");
        return RefreshTokenModel(
            token: data['token'], refreshToken: data['refreshToken']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("error getting refresh token");
    }
  }
}
