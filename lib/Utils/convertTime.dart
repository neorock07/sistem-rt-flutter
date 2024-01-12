import 'package:intl/intl.dart';

class convertTime {
  String convert(dynamic unix) {
    DateTime tm = DateTime.fromMillisecondsSinceEpoch(unix);
    String formatTm = DateFormat('dd-MMM-yyyy HH:mm:ss').format(tm);
    return formatTm;
  }

  String addLeadingZero(int number) {
    // Menambahkan nol di depan angka jika kurang dari 10
    return number.toString().padLeft(2, '0');
  }
}
