import 'package:intl/intl.dart';
import 'dart:io';

String formatPrice(int price) {
  return '${getCurrency()}${NumberFormat('#,###,###,###').format(price)}';
}

String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}