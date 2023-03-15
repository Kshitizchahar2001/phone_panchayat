// import 'package:easy_localization/easy_localization.dart';
// import 'package:online_panchayat_flutter/constants/hindiAlphabets.dart';
// ignore_for_file: avoid_print, missing_return

import 'package:online_panchayat_flutter/utils/humanizeNumber.dart';

void main() {
  // List hindi = ["मेरी", "पलब्ध", "तहसील", "नहीं", "है"];

  // for (int i = 0; i < hindi.length; i++) {
  //   print(hindi[i]);
  // }
//   print(NumberFormatter.formatter('1200'));
//   var _formattedNumber = NumberFormat.compact().format(numberToFormat);
//   print('Formatted Number is $numberToFormat');
  String n1 = humanizeInt(null); // 1.2K
  print(n1);
}

class NumberFormatter {
  static String formatter(String currentBalance) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);

      if (value < 1000000) {
        // less than a million
        return value.toStringAsFixed(2);
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(2) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(2) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(2) + "T";
      }
    } catch (e) {
      print(e);
    }
  }
}
