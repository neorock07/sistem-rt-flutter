import 'package:flutter/material.dart';

class DetailKeluarga extends StatelessWidget {

  String? kk;
  DetailKeluarga({
    super.key,
    this.kk
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
        title: Text("${kk}"),
      ),
      body: Column(
        children: [
          Text("Kosongan")
        ],
      ),
    );
  }
}