import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}

class LoggerService {
  static final LoggerService instance = LoggerService._();
  factory LoggerService() => instance;
  LoggerService._();

  final Logger _logger = Logger(filter: CustomLogFilter());

  errorLogger(String data) => _logger.e(data);

  infoLogger(String data) => _logger.i(data);

  debugLogger(String data) => _logger.d(data);
}

errorLogger(var data) {
  return LoggerService.instance.errorLogger(data);
}

successLogger(var data) {
  return LoggerService.instance.infoLogger(data);
}