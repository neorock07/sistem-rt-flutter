
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadioButtonPilih extends GetxController{
 RxString text = "".obs;

 String UpdateText(String txt){
  text.value = txt;
  return text.value;
 } 
}

class CapitalController extends GetxController{
  var capital = "".obs;

  String toCapital(String txt){
    capital.value = txt.toUpperCase();
    return capital.value;
  }
}

class ClearFieldController extends GetxController{
  var text = "".obs;
  String Clear(){
    return text.value;
  }
}

class SelectTextController extends GetxController{
  var txt = "".obs;
  String onChange(String msg){
    txt.value = msg;
    return txt.value;
  }

}
