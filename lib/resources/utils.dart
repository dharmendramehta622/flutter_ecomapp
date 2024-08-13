import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension DateTimeExtension on DateTime {
  
  String get format => DateFormat().add_yMMMMd().add_Hm().format(toLocal());

  String get formatMonth => DateFormat().add_yMMMd().format(toLocal());

  String get formatDateFull => DateFormat().format(toLocal());

  String get formatTime => DateFormat('HH:mm').format(toLocal());

  String get formatDateMonth => DateFormat('yyyy-MM-dd').format(toLocal());

  String get formatMonthDate => DateFormat('MMMM d, yyyy').format(toLocal());
  
  // Format DateTime to 'dd-MM-yyyy' format
  String get formatDateDayMonthYear => DateFormat('dd-MM-yyyy').format(toLocal());

  // New custom format method
  String get customFormat => DateFormat('EEE, d MMMM yyyy').format(toLocal());

  // New custom time format method for "03:45 PM"
  String get customTimeFormat => DateFormat('h:mm a').format(toLocal());
  
  // ISO 8601 format method with milliseconds only
  String get iso8601Format => DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(toUtc());
  
    // Format DateTime to local time in ISO 8601 format with milliseconds
  String get localIso8601Format => DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(this);

 }
