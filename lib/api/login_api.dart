import 'package:desktop_app_demo/Util/shared_prefence_util.dart';
import 'package:desktop_app_demo/model/login_request.dart';
import 'package:desktop_app_demo/model/user_response.dart';
import 'package:dio/dio.dart';

class LoginAPI {
  final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();

  Future<UserResponse?> loginAPI(LoginRequest loginRequest) async {
    var dio = Dio();
    Map<String, dynamic> request = {
      "email": loginRequest.email,
      "password": loginRequest.password != null
          ? int.tryParse(loginRequest.password!)
          : 0
    };
    FormData formData = FormData.fromMap(request);
    final response = await dio.post(
        'https://139.59.79.228/flutter-api/public/api/login',
        data: formData);
    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.data);
    }
  }
}
