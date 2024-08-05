import 'package:geolocator/geolocator.dart';
import 'package:new_project/Networks/ApiServices.dart';
import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/models/clockin_model.dart';

class ClockInServices {
  Future<ApiResponse> createClockIn(Position position) async {
    Map<String, dynamic> variables = {
      "check_in": DateTime.now(),
      "lat": "${position.latitude}",
      "long": "${position.longitude}"
    };
    final response = await ApiServices.instance
        .get(url: '/attendance/clockin/', variables: variables);
    return response;
  }

  Future<ApiResponse> clockOut() async {
    final response = await ApiServices.instance
        .get(url: '/attendance/clockin/', variables: {});
    return response;
  }

  Future<ClockInReportModel> getClockInReport() async {
    final response = await ApiServices.instance
        .get(url: '/attendance/clockin/', variables: {});
    return ClockInReportModel.fromMap(response.msg?.data["results"]);
  }
}
