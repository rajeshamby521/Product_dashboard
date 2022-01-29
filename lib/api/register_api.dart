import 'package:desktop_app_demo/model/register_request.dart';
import 'package:desktop_app_demo/model/register_response.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class RegisterAPI {
  Future<RegisterResponse?> registerAPIWithoutImage(
    RegisterRequest registerRequest,
  ) async {
    var dio = Dio();
    FormData formData = FormData.fromMap({
      'name': registerRequest.name,
      'email': registerRequest.email,
      'password': registerRequest.password != null
          ? int.tryParse(registerRequest.password!)
          : 0,
      'password_confirmation': registerRequest.confirmPassword != null
          ? int.tryParse(registerRequest.confirmPassword!)
          : 0,
      'gender': registerRequest.gender,
      'birth_date': registerRequest.birthDate,
    });
    final response = await dio.post(
        'https://139.59.79.228/flutter-api/public/api/register',
        data: formData);
    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(response.data);
    }
  }

  Future<RegisterResponse?> registerAPIWithImage(
      RegisterRequest registerRequest, PlatformFile file) async {
    var dio = Dio();
    FormData formData = FormData.fromMap({
      'name': registerRequest.name,
      'email': registerRequest.email,
      'password': registerRequest.password != null
          ? int.tryParse(registerRequest.password!)
          : 0,
      'password_confirmation': registerRequest.confirmPassword != null
          ? int.tryParse(registerRequest.confirmPassword!)
          : 0,
      'gender': registerRequest.gender,
      'birth_date': registerRequest.birthDate,
      'image': await MultipartFile.fromFile(file.path!, filename: file.name),
    });
    final response = await dio.post(
        'https://139.59.79.228/flutter-api/public/api/register',
        data: formData);
    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(response.data);
    }
  }
}
