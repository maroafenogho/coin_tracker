import 'dart:io';

import 'package:intl/intl.dart';

extension FormattedNumber on double {
  String get formattedNumber {
    final dynamic c;
    c = NumberFormat("#,##0.00", Platform.localeName);
    return c.format(this);
  }
}
