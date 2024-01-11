import "dart:convert";
import "dart:developer";

import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart";
import 'package:http/http.dart' as http;
import "package:sistem_rt/Controller/RefreshTokenController/RefreshTokenController.dart";
import "package:sistem_rt/Utils/Ip.dart";

class DataDiriController extends GetxController {
  var ipAdd = Ip();
  var isOk = false.obs;
  var status = 0.obs;
  Map<String, AnggotaModel>? data;
  var refController = Get.put(RefreshTokenController());

  @override
  void onInit() {
    getNewToken();
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
      refController.getRefreshToken(refreshToken!).then((value) {
        token = value!.token;
        refreshToken = value.refreshToken;
      });
      Get.snackbar("Get New Token", "Mendapatkan token");
    }
  }

  Future<void> insert({
    AnggotaModel? model,
    String? kk,
    String? token,
  }) async {
    Map<String, dynamic> dt = {
      "id": model!.id,
      "keluarga_id": {"id": kk},
      "nama": model.nama,
      "no_telp": model.no_telp,
      "tgl_lahir": model.tgl_lahir,
      "tempat_lahir": model.tempat_lahir,
      "jenis_kelamin": model.jenis_kelamin,
      "pekerjaan": model.pekerjaan,
      "bangsa": model.bangsa,
      "negara": model.negara,
      "prov": model.prov,
      "status_kawin": model.isKawin,
      "kota": model.kota,
      "kecamatan": model.kecamatan,
      "alamat": model.alamat
    };

    var response = await http.post(
        Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/anggota"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(dt));
    if (response.statusCode == 200) {
      isOk.value = true;
      status.value = 200;
    } else {
      isOk.value = false;
      status.value = response.statusCode;
    }
    log("pesan : ${response.statusCode.toString()}");
  }

  Future<Map<String, AnggotaModel?>?> getById({String? id}) async {
    try {
      var response = await http.get(Uri.parse(
          "${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/anggota/${id}"));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      Get.snackbar("Error get data", "tidak dapat menemukan data");
      throw Exception("tidak data menemukan data");
    }
  }
}
