
import 'dart:convert'; 
import 'package:equatable/equatable.dart';

class SessionInfo extends Equatable {
  final String token;
  final String id;

  const SessionInfo({
   required this.token,
  required  this.id,
  });

  SessionInfo copyWith({String? token, String? id}) {
    return SessionInfo(token: token ?? this.token, id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
    };
  }

  factory SessionInfo.fromMap(Map<dynamic, dynamic>? map) {
    return SessionInfo(token: map!['token'], id: map['id']);
  }

  String toJson() => json.encode(toMap());

  factory SessionInfo.fromJson(String source) =>
      SessionInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, id];
}
