import "dart:convert";
import "dart:developer";

import "package:get/get.dart";
import 'package:http/http.dart' as http;

import "../../API/Model/WilayahModel/ProvinsiModel/ProvinsiModel.dart";

class WilayahController extends GetxController {
  Map<String, dynamic>? data;
  var dt_prov = <ProvinsiModel>[].obs;  

  @override
  void onInit() {
    super.onInit();
    getProvinsi();
  }

  Future<List<ProvinsiModel>?> getProvinsi() async {
    var response = await http.get(
      Uri.parse("https://alamat.thecloudalert.com/api/provinsi/get/"),
      headers: {"content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      log("data : ${data!['result']}");
      dt_prov.value = data!['result'];      
    }else{
      log("error tidak dapat get data");
    }
  }
}
