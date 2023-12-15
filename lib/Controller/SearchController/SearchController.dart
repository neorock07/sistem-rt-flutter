import 'package:get/get.dart';
import 'package:sistem_rt/API/Model/KepalaKelModel/AdminModel.dart';

class BongkarController extends GetxController{

  var filtered = <AdminModel>[].obs;

  List<AdminModel?>? Bongkar(String kueri, List<AdminModel>? items) {
      filtered.value = items!.where((element) => element.username!.toLowerCase().contains(kueri.toLowerCase())).toList();
      return filtered.value;
  }   

}