import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserRegisterEvent extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final String birthDate;
  final String name;
  final PlatformFile? file;

  UserRegisterEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.gender,
      required this.birthDate,
      required this.confirmPassword,
      this.file});
}

class NameChangeEvent extends RegisterEvent {
  final String? name;

  NameChangeEvent(this.name);
}

class EmailChangeEvent extends RegisterEvent {
  final String? email;

  EmailChangeEvent(this.email);
}

class PasswordChangeEvent extends RegisterEvent {
  final String? password;

  PasswordChangeEvent(this.password);
}

class ConfirmPasswordChangeEvent extends RegisterEvent {
  final String? password;

  ConfirmPasswordChangeEvent(this.password);
}

class BirthDateChangeEvent extends RegisterEvent {
  final String? birthday;

  BirthDateChangeEvent(this.birthday);
}

class GenderChangeEvent extends RegisterEvent {
  final String? gender;

  GenderChangeEvent(this.gender);
}

class FilePickerEvent extends RegisterEvent {
  final PlatformFile? file;

  FilePickerEvent(this.file);
}
