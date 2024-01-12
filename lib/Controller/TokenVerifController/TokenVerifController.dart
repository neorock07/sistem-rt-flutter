import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_rt/Utils/Ip.dart';
import '../../API/Model/TokenVerif/TokenModel.dart';

class TokenVerifController extends GetxController{

  var valToken = "".obs;
  var ip = Ip();

  Future<bool> VerifSuper(String token)async{
      var response = await http.get(
          Uri.parse("${ip.getType()}://${ip.getIp()}/api/token-verif"),
      );
      
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        valToken.value = TokenModel.fromJson(data[0]).token!;
        log("data token : ${valToken.value}");
        return (valToken.value.trim() == token.trim())? true : false;
      }else{
        Get.snackbar("Data tidak ditemukan", "Data token tidak ditemukan");
        throw Error();
      }
  }

} 