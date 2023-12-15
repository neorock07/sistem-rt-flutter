import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefController extends GetxController {


  Future<void> saveData({String? email, String? password, String? role, String? token, String? refreshToken}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email!);
    await pref.setString("password", password!);
    await pref.setString("role", role!);
    await pref.setString("token", token!);
    await pref.setString("refreshToken", refreshToken!);
  }
  Future<void> saveNewToken({String? token, String? refreshToken}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token!);
    await pref.setString("refreshToken", refreshToken!);
  }

  Future<String?> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  Future<String?> getEmail() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email")!.split("@gmail.com")[0];
  }

  Future<bool?> cekKey(String? key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return (pref.containsKey(key!)? true : false);
  }



}