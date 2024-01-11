import 'package:intl/intl.dart';

class convertTime{

  String convert(dynamic unix){
    DateTime tm = DateTime.fromMillisecondsSinceEpoch(unix);
    String formatTm = DateFormat('dd-MMM-yyyy HH:mm:ss').format(tm);
    return formatTm;
  }

}