import "dart:convert";
import "dart:developer";

import "package:get/get.dart";
import "package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart";
import 'package:http/http.dart' as http;
import "package:sistem_rt/Utils/Ip.dart";

class DataDiriController extends GetxController {
  var ipAdd = Ip();
  var isOk = false.obs;
  var status = 0.obs;

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
      "kota": model.kota,
      "kecamatan": model.kecamatan,
      "alamat": model.alamat
    };
    var response = await http
        .post(Uri.parse("${ipAdd.getType()}://${ipAdd.getIp()}/api/v1/anggota"),
         headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token'
    }, body: jsonEncode(dt));
    if(response.statusCode == 200){
      isOk.value = true;
      status.value = 200;
    }else{
      isOk.value = false;
      status.value = response.statusCode;
    }
    log("pesan : ${response.statusCode.toString()}");
  }
}
