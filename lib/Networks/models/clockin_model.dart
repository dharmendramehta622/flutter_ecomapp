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
    final User? user;
    final DateTime? createdAt;
    final DateTime? checkIn;
    final DateTime? checkOut;
    final String? lat;
    final String? long;

    ClockInModel({
        this.id,
        this.user,
        this.createdAt,
        this.checkIn,
        this.checkOut,
        this.lat,
        this.long,
    });

    ClockInModel copyWith({
        int? id,
        User? user,
        DateTime? createdAt,
        DateTime? checkIn,
        DateTime? checkOut,
        String? lat,
        String? long,
    }) => 
        ClockInModel(
            id: id ?? this.id,
            user: user ?? this.user,
            createdAt: createdAt ?? this.createdAt,
            checkIn: checkIn ?? this.checkIn,
            checkOut: checkOut ?? this.checkOut,
            lat: lat ?? this.lat,
            long: long ?? this.long,
        );

    factory ClockInModel.fromJson(String str) => ClockInModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ClockInModel.fromMap(Map<String, dynamic> json) => ClockInModel(
        id: json["id"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null ? null : DateTime.parse(json["check_out"]),
        lat: json["lat"],
        long: json["long"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user": user?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "check_in": checkIn?.toIso8601String(),
        "check_out": checkOut?.toIso8601String(),
        "lat": lat,
        "long": long,
    };
}

class User {
    final String? id;
    final String? role;
    final String? email;
    final String? phoneNo;
    final String? firstName;
    final String? lastName;
    final dynamic userImage;
    final bool? isActive;
    final DateTime? dateJoined;
    final DateTime? lastLogin;
    final bool? emailVerified;

    User({
        this.id,
        this.role,
        this.email,
        this.phoneNo,
        this.firstName,
        this.lastName,
        this.userImage,
        this.isActive,
        this.dateJoined,
        this.lastLogin,
        this.emailVerified,
    });

    User copyWith({
        String? id,
        String? role,
        String? email,
        String? phoneNo,
        String? firstName,
        String? lastName,
        dynamic userImage,
        bool? isActive,
        DateTime? dateJoined,
        DateTime? lastLogin,
        bool? emailVerified,
    }) => 
        User(
            id: id ?? this.id,
            role: role ?? this.role,
            email: email ?? this.email,
            phoneNo: phoneNo ?? this.phoneNo,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            userImage: userImage ?? this.userImage,
            isActive: isActive ?? this.isActive,
            dateJoined: dateJoined ?? this.dateJoined,
            lastLogin: lastLogin ?? this.lastLogin,
            emailVerified: emailVerified ?? this.emailVerified,
        );

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        role: json["role"],
        email: json["email"],
        phoneNo: json["phone_no"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userImage: json["user_image"],
        isActive: json["is_active"],
        dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        emailVerified: json["email_verified"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "role": role,
        "email": email,
        "phone_no": phoneNo,
        "first_name": firstName,
        "last_name": lastName,
        "user_image": userImage,
        "is_active": isActive,
        "date_joined": dateJoined?.toIso8601String(),
        "last_login": lastLogin?.toIso8601String(),
        "email_verified": emailVerified,
    };
}
