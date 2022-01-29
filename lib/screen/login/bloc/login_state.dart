import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool? isSuccessLogin;
  final bool? isLoading;
  final bool? isFailedLogin;
  final bool? validEmail;
  final bool? validPassword;
  final bool? disable;

  LoginState copyWith({
    bool? isSuccessLogin,
    bool? isLoading,
    bool? isFailedLogin,
    bool? validEmail,
    bool? validPassword,
    bool? disable,
  }) {
    return LoginState(
      isSuccessLogin: isSuccessLogin ?? this.isSuccessLogin,
      isLoading: isLoading ?? this.isLoading,
      isFailedLogin: isFailedLogin ?? this.isFailedLogin,
      validEmail: validEmail ?? this.validEmail,
      validPassword: validPassword ?? this.validPassword,
      disable: disable ?? this.disable,
    );
  }

  const LoginState({
    this.isSuccessLogin,
    this.isLoading = false,
    this.isFailedLogin = false,
    this.validEmail,
    this.validPassword,
    this.disable = true,

  });

  @override
  List<Object?> get props => [
        isSuccessLogin,
        isLoading,
        isFailedLogin,
        validEmail,
        validPassword,
        disable,
      ];
}
