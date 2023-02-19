import 'dart:io';

import 'package:intl/intl.dart';

extension FormattedNumber on double {
  String get formattedNumber {
    final dynamic c;
    c = NumberFormat("#,##0.00", Platform.localeName);
    return c.format(this);
  }
}

extension IntFromDouble on double {
  int get intFromDouble {
    String numString = toString().split('.')[0];
    return int.parse(numString);
  }
}

extension Day on String {
  String get formattedDay {
    String day = '';
    if (this == '1D') {
      day = '1';
    } else if (this == '1W') {
      day = '7';
    } else if (this == '1M') {
      day = '30';
    } else if (this == '1Y') {
      day = '365';
    } else if (this == 'MAX') {
      day = 'max';
    }
    return day;
  }
}
