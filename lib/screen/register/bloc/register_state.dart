import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool? isSuccessLogin;
  final bool? isLoading;
  final bool? isName;
  final bool? validEmail;
  final bool? validPassword;
  final bool? validConfirmPassword;
  final bool? validGender;
  final bool? birthDate;
  final bool? isFailedRegister;
  final bool? isDisable;

  RegisterState copyWith({
    bool? isSuccessLogin,
    bool? isLoading,
    bool? isName,
    bool? validEmail,
    bool? validPassword,
    bool? validConfirmPassword,
    bool? validGender,
    bool? birthDate,
    String? gender,
    String? password,
    bool? isFailedRegister,
    bool? isDisable,
  }) {
    return RegisterState(
      isSuccessLogin: isSuccessLogin ?? this.isSuccessLogin,
      isLoading: isLoading ?? this.isLoading,
      isName: isName ?? this.isName,
      validEmail: validEmail ?? this.validEmail,
      validPassword: validPassword ?? this.validPassword,
      validConfirmPassword: validConfirmPassword ?? this.validConfirmPassword,
      birthDate: birthDate ?? this.birthDate,
      validGender: validGender ?? this.validGender,
      isFailedRegister: isFailedRegister ?? this.isFailedRegister,
      isDisable: isDisable ?? this.isDisable,
    );
  }

  const RegisterState({
    this.isSuccessLogin,
    this.isLoading = true,
    this.isName = true,
    this.validEmail = true,
    this.validPassword = true,
    this.validConfirmPassword = true,
    this.birthDate = true,
    this.validGender = true,
    this.isFailedRegister = false,
    this.isDisable = true,
  });

  @override
  List<Object?> get props => [
        isSuccessLogin,
        isLoading,
        isName,
        validEmail,
        validPassword,
        validConfirmPassword,
        birthDate,
        isFailedRegister,
        isDisable,
        validGender,
      ];
}
