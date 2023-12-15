import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_rt/Controller/DataWilayah/WilayahController.dart';

class AddManual extends StatefulWidget {
  const AddManual({Key? key}) : super(key: key);

  @override
  _AddManualState createState() => _AddManualState();
}

class _AddManualState extends State<AddManual> {
  var kontroler = Get.put(WilayahController());

  @override
  void initState() {
    super.initState();
    FutureBuilder(
      future: kontroler.getProvinsi(),
      builder: (_, snap) => Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => (kontroler.dt_prov.isNotEmpty)?
      Text("${kontroler.dt_prov}") : CircularProgressIndicator()),
    );
  }
}
