import "package:flutter/material.dart";

class ResultScan extends StatelessWidget {
  List<String>? text;
  ResultScan({ super.key, this.text });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("NIK :  ${text![9]}\nNama : ${text![16]}\n")
        ],
      ),
    );
  }
}