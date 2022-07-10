extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isAfterDate(DateTime other) {
    return year == other.year && month == other.month && day < other.day;
  }

  bool isBeforeTime(DateTime other) {
    return year >= other.year &&
        month >= other.month &&
        day >= other.day &&
        millisecondsSinceEpoch >= other.millisecondsSinceEpoch;
  }

  bool isAfterTime(DateTime other) {
    return year <= other.year &&
        month <= other.month &&
        day <= other.day &&
        millisecondsSinceEpoch <= other.millisecondsSinceEpoch;
  }

  bool isBeforeDate(DateTime other) {
    return year == other.year && month == other.month && day > other.day;
  }
}