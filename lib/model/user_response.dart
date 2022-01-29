

import 'user.dart';

class UserResponse {
  String? token;
  String? tokenType;
  bool? status;
  User? user;

  UserResponse({this.token, this.tokenType, this.status,this.user});

  UserResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        tokenType = json['token_type'],
        status = json['status'],
        user = User.fromJson(json['user']);
}
