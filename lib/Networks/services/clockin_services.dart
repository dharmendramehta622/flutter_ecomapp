import 'package:new_project/Networks/ApiServices.dart';
import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/models/clockin_model.dart';

class ClockInServices {
  
  Future<ApiResponse> createClockIn() async {
    final response = await ApiServices.instance
        .get(url: '/attendance/clockin/', variables: {});
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
