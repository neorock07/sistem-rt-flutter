import 'package:flutter/material.dart';

Widget DragSheet(
  BuildContext context,
  ScrollController? Controller,
  {
  double? initChild,
  double? minChild,
  double? maxChild,
  Widget? widget,
}){
  return DraggableScrollableSheet(
    initialChildSize: initChild!,
    minChildSize: minChild!,
    maxChildSize: maxChild!,
      
    builder: ((context, scrollController) {
        Controller = scrollController;
        return widget!;
    })
    );
}