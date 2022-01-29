import 'package:desktop_app_demo/model/register.dart';

class RegisterResponse {
  bool? status;
  String? token;
  Register? register;

  RegisterResponse({this.token, this.status, this.register});

  RegisterResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        status = json['status'],
        register = Register.fromJson(json['data']);
}
