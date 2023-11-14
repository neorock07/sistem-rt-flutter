import 'package:get/get.dart';

class ObscureController extends GetxController{
  var isVisible = true.obs;

  bool changeCondition(){
    isVisible.value = !isVisible.value;
    return isVisible.value;
  }

  // void ObscureOpen(){
  //   isVisible.value = true;
  // }

  // void ObscureHide(){
  //   isVisible.value = false;
  // }
  
}
