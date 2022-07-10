import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StringHelper {
  static Future<String> getPublicIP() async {
    try {
      const url = 'https://api.ipify.org';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String utcFormatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatTimeWithoutSecond(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String formatDatePointSeparator(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static String formatDatePointSeparatorFull(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }

  static String formatDateWithDayName(DateTime dateTime) {
    return DateFormat('E ,MMMM dd, yyyy').format(dateTime);
  }

  static String getPairPrice({
    required String currencyPairString,
    required double price,
    required int decimal,
  }) {
    String value = price.toString();
    String afterZero = '';
    if (currencyPairString != 'CLSK' && currencyPairString != 'XAUUSD') {
      afterZero = price
          .toString()
          .split('.')
          .last
          .padRight(decimal, '0')
          .substring(0, decimal - 1);
    } else {
      afterZero = '';
      afterZero = price
          .toString()
          .split('.')
          .last
          .padRight(decimal, '0')
          .substring(0, decimal);
    }
    value = price.toString().split('.').first + '.' + afterZero;
    return value;
  }

  static String getQPairPrice({
    required String currencyPairString,
    required double price,
    required int decimal,
  }) {
    String value = '';
    if (currencyPairString != 'CLSK' && currencyPairString != 'XAUUSD') {
      value = price.toString().split('.').last.padRight(decimal, '0').substring(
          decimal - 1,
          price.toString().split('.').last.padRight(decimal, '0').length);
    }
    return value;
  }

  static String coursePercent(int duration, int watchedDuration) {
    int _percent = (watchedDuration / duration * 100).ceil();
    if (_percent == 0) {
      return '0';
    }
    return (_percent + 5 - (_percent % 5)).toString();
  }

  static double truncateToDecimalPlaces(double value, int fractionalDigits) => (value * pow(10,
      fractionalDigits)).truncate() / pow(10, fractionalDigits);
}
