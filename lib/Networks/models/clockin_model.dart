import 'dart:convert';

class PaginationModel {
  final int limit;
  final int offset;
  final bool resetList;

  PaginationModel({int limit = 5, int offset = 0, this.resetList = false})
      : limit = limit,
        offset = offset;

  PaginationModel copyWith({
    int? limit,
    int? offset,
    bool? resetList,
  }) {
    return PaginationModel(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      resetList: resetList ?? this.resetList,
    );
  }
}

PaginationModel globalPagination = PaginationModel();

class ClockInReportModel {
    final double? totalHours;
    final List<ClockInModel>? results;

    ClockInReportModel({
        this.totalHours,
        this.results,
    });

    ClockInReportModel copyWith({
        double? totalHours,
        List<ClockInModel>? results,
    }) => 
        ClockInReportModel(
            totalHours: totalHours ?? this.totalHours,
            results: results ?? this.results,
        );

    factory ClockInReportModel.fromJson(String str) => ClockInReportModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ClockInReportModel.fromMap(Map<String, dynamic> json) => ClockInReportModel(
        totalHours: json["total_hours"]?.toDouble(),
        results: json["results"] == null ? [] : List<ClockInModel>.from(json["results"]!.map((x) => ClockInModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total_hours": totalHours,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toMap())),
    };
}
 
class ClockInReport {
  final List<ClockInModel> data;
  final int totalHours;

  ClockInReport(this.data, this.totalHours);
}

class ClockInModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? lat;
  final String? long;
  final String? user;

  ClockInModel({
    this.id,
    this.createdAt,
    this.checkIn,
    this.checkOut,
    this.lat,
    this.long,
    this.user,
  });

  ClockInModel copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? checkIn,
    DateTime? checkOut,
    String? lat,
    String? long,
    String? user,
  }) =>
      ClockInModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        checkIn: checkIn ?? this.checkIn,
        checkOut: checkOut ?? this.checkOut,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        user: user ?? this.user,
      );

  factory ClockInModel.fromJson(String str) =>
      ClockInModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClockInModel.fromMap(Map<String, dynamic> json) => ClockInModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        checkIn:
            json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null
            ? null
            : DateTime.parse(json["check_out"]),
        lat: json["lat"],
        long: json["long"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "check_in": checkIn?.toIso8601String(),
        "check_out": checkOut?.toIso8601String(),
        "lat": lat,
        "long": long,
        "user": user,
      };
}
