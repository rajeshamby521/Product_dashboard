import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoginEvent extends LoginEvent {
  final String? email;
  final String? password;

  UserLoginEvent({this.email, this.password});
}

class EmailChangeEvent extends LoginEvent {
  final String? email;

  EmailChangeEvent(this.email);
}

class PasswordChangeEvent extends LoginEvent {
  final String? password;

  PasswordChangeEvent(this.password);
}

class DisableButton extends LoginEvent{

}
