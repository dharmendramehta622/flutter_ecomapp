import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum GraphEnumRange { week, month, ytd, year, max }

extension DateTimeExtension on DateTime {
  String get format => DateFormat().add_yMMMMd().add_Hm().format(toLocal());

  String get formatMonth => DateFormat().add_yMMMd().format(toLocal());

  String get formatDateFull => DateFormat().format(toLocal());

  String get formatTime => DateFormat('HH:mm').format(toLocal());

  String get formatDateMonth => DateFormat('yyyy-MM-dd').format(toLocal());

  String get formatMonthDate => DateFormat('MMMM d, yyyy').format(toLocal());

  // New custom format method
  String get customFormat => DateFormat('EEE, d MMMM yyyy').format(toLocal());

  // New custom time format method for "03:45 PM"
  String get customTimeFormat => DateFormat('h:mm a').format(toLocal());
  
  String timeAgoString() {
    DateTime now = DateTime.now().toUtc();
    Duration timeDiff = now.difference(this);

    if (timeDiff.inSeconds < 60) {
      return 'just now';
    } else if (timeDiff.inMinutes < 60) {
      int minutes = timeDiff.inMinutes;
      return '${minutes}m ago';
    } else if (timeDiff.inHours < 24) {
      int hours = timeDiff.inHours;
      return '${hours}h ago';
    } else if (timeDiff.inDays < 30) {
      int days = timeDiff.inDays;
      return '${days}d ago';
    } else if (timeDiff.inDays < 365) {
      int months = (timeDiff.inDays / 30).round();
      return '${months}m ago';
    } else {
      int years = (timeDiff.inDays / 365).round();
      return '${years}y ago';
    }
  }

  String timeAgoShortString() {
    DateTime now = DateTime.now().toUtc();
    Duration timeDiff = now.difference(this);

    if (timeDiff.inSeconds < 60) {
      return 'now';
    } else if (timeDiff.inMinutes < 60) {
      int minutes = timeDiff.inMinutes;
      return '${minutes}m';
    } else if (timeDiff.inHours < 24) {
      int hours = timeDiff.inHours;
      return '${hours}h';
    } else if (timeDiff.inDays < 30) {
      int days = timeDiff.inDays;
      return '${days}d';
    } else if (timeDiff.inDays < 365) {
      int months = (timeDiff.inDays / 30).round();
      return '${months}m';
    } else {
      int years = (timeDiff.inDays / 365).round();
      return '${years}y';
    }
  }

  DateTimeRange getWeekRange() {
    DateTime now = DateTime.now();
    // Calculate the end of the week (today)
    DateTime endOfWeek = DateTime(now.year, now.month, now.day);
    // Calculate the start of the week (7 days back from today)
    DateTime startOfWeek = endOfWeek.subtract(const Duration(days: 8));
    return DateTimeRange(start: startOfWeek, end: endOfWeek);
  }

  DateTimeRange getMonthRange() {
    DateTime now = DateTime.now();
    DateTime startOfMonth = now.subtract(const Duration(days: 31));
    DateTime endOfMonth = DateTime(now.year, now.month, now.day);
    return DateTimeRange(start: startOfMonth, end: endOfMonth);
  }

  DateTimeRange getYearToDateRange() {
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear = DateTime(now.year, now.month, now.day);
    return DateTimeRange(start: startOfYear, end: endOfYear);
  }

  DateTimeRange getYearRange() {
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear = DateTime(now.year, 12, 31);
    return DateTimeRange(start: startOfYear, end: endOfYear);
  }

  DateTimeRange getMaxRange() {
    // Assuming you have a list of dates or some way to determine the range
    // Replace the following sample values with your actual data
    DateTime minDate = DateTime(2000, 1, 1);
    DateTime maxDate = DateTime.now();
    return DateTimeRange(start: minDate, end: maxDate);
  }

  DateTimeRange getDateRange(GraphEnumRange interval) {
    switch (interval) {
      case GraphEnumRange.week:
        return getWeekRange();
      case GraphEnumRange.month:
        return getMonthRange();
      case GraphEnumRange.ytd:
        return getYearToDateRange();
      case GraphEnumRange.year:
        return getYearRange();
      case GraphEnumRange.max:
        return getMaxRange();
      default:
        throw ArgumentError('Invalid interval: $interval');
    }
  }
}
