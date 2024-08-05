import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:new_project/Networks/ApiServices.dart';
import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/models/clockin_model.dart';
import 'package:new_project/resources/utils.dart';

class ClockInServices {
  Future<ApiResponse> createClockIn(Position position) async {
    Map<String, dynamic> variables = {
      "lat": position.latitude.toStringAsFixed(6),
      "long": position.longitude.toStringAsFixed(6)
    };
    final response = await ApiServices.instance
        .post(url: '/attendance/clockin/', variables: variables);
    return response;
  }

  Future<ApiResponse> clockOut(ClockInModel model) async {
    Map<String, dynamic> variables = {
      "check_out": DateTime.now().iso8601Format.toString()
    };
    final response = await ApiServices.instance
        .patch(url: '/attendance/clockin/${model.id}/', variables: variables);
    return response;
  }

  Future<ClockInReportModel> getClockInReport() async {
    final response = await ApiServices.instance
        .get(url: '/attendance/clockin/', variables: {});
    return ClockInReportModel.fromMap(response.msg?.data["results"]);
  }

  Future<ClockInModel?> getClockInStatus() async {
    final response = await ApiServices.instance
        .get(url: '/attendance/clockin/', variables: {});
    // Get today's date in UTC format
    String todayDateString =
        DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc());

    // Find the model with check_in date equal to today's date
    var resultModel = (response.msg?.data['results']['results'] as List)
        .cast<Map<String, dynamic>>()
        .firstWhere(
      (model) {
        var checkInDate = DateTime.parse(model['check_in']);
        String checkInDateString =
            DateFormat('yyyy-MM-dd').format(checkInDate.toUtc());
        return checkInDateString == todayDateString &&
            model['check_out'] == null;
      },
      orElse: () => {},
    );
    // Return a ClockInModel or null if resultModel is an empty map
    return resultModel.isNotEmpty ? ClockInModel.fromMap(resultModel) : null;
  }
}
