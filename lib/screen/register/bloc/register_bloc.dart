import 'package:desktop_app_demo/Util/shared_prefence_util.dart';
import 'package:desktop_app_demo/api/register_api.dart';
import 'package:desktop_app_demo/model/register_request.dart';
import 'package:desktop_app_demo/screen/register/bloc/register_event.dart';
import 'package:desktop_app_demo/screen/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  String? name;
  String? isEmail;
  String? password;
  String? confirmPassword;
  String? dateOfBirth;
  String? gender;

  final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();

  RegisterBloc() : super(const RegisterState()) {
    on<UserRegisterEvent>(_registerUser);
    on<NameChangeEvent>(_nameValid);
    on<EmailChangeEvent>(_emailValid);
    on<PasswordChangeEvent>(_passwordValid);
    on<ConfirmPasswordChangeEvent>(_confirmPasswordValid);
    on<BirthDateChangeEvent>(_birthDate);
    on<GenderChangeEvent>(_gender);
    on<FilePickerEvent>(_filePicker);
  }

  void _registerUser(
      UserRegisterEvent event, Emitter<RegisterState> emit) async {
    if (event.name.isNotEmpty &&
        state.validEmail == true &&
        state.validConfirmPassword == true &&
        state.validPassword == true &&
        event.gender.isNotEmpty &&
        event.birthDate.isNotEmpty) {
      emit(state.copyWith(
        isSuccessLogin: false,
        isLoading: false,
      ));
      RegisterAPI registerAPI = RegisterAPI();
      RegisterRequest registerRequest = RegisterRequest();
      registerRequest.name = event.name;
      registerRequest.email = event.email;
      registerRequest.password = event.password;
      registerRequest.confirmPassword = event.confirmPassword;
      registerRequest.gender = event.gender;
      registerRequest.birthDate = event.birthDate;
      if (event.file != null) {
        // register with profile
        var response = await registerAPI.registerAPIWithImage(
            registerRequest, event.file!);

        if (response != null) {
          emit(state.copyWith(
            isSuccessLogin: true,
            isLoading: true,
          ));
        } else {
          emit(state.copyWith(
            isSuccessLogin: false,
            isLoading: true,
            isFailedRegister: true,
          ));
        }
      } else {
        // register without profile
        var response = await registerAPI.registerAPIWithoutImage(
          registerRequest,
        );
        if (response != null) {
          emit(state.copyWith(
            isSuccessLogin: true,
            isLoading: true,
          ));
        } else {
          emit(state.copyWith(
            isSuccessLogin: false,
            isLoading: true,
            isFailedRegister: true,
          ));
        }
      }
    } else {
      emit(state.copyWith());
    }
  }

  void _nameValid(NameChangeEvent event, Emitter<RegisterState> emit) async {
    if (event.name!.isNotEmpty) {
      name = event.name;
      emit(state.copyWith(
        isName: true,
        isDisable: false,
      ));

      // btn enable disable condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(
        isName: false,
        isDisable: true,
      ));
    }
    if (event.name != null) {
      emit(state.copyWith(
        isFailedRegister: false,
      ));
    }
  }

  void _emailValid(EmailChangeEvent event, Emitter<RegisterState> emit) async {
    RegExp email = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    if (event.email != null && email.hasMatch(event.email!)) {
      isEmail = event.email;
      emit(state.copyWith(
        validEmail: true,
        isDisable: false,
      ));

      // btn enable disable condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(
        validEmail: false,
        isDisable: true,
      ));
    }
    if (event.email != null) {
      emit(state.copyWith(
        isFailedRegister: false,
      ));
    }
  }

  void _passwordValid(
      PasswordChangeEvent event, Emitter<RegisterState> emit) async {
    if (event.password != null && event.password!.length >= 8) {
      password = event.password;
      emit(
        state.copyWith(
          validPassword: true,
          isDisable: false,
        ),
      );

      // btn enable disable condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(
        validPassword: false,
        isDisable: true,
      ));
    }
    if (event.password != null) {
      emit(state.copyWith(
        isFailedRegister: false,
      ));
    }
  }

  void _confirmPasswordValid(
      ConfirmPasswordChangeEvent event, Emitter<RegisterState> emit) {
    if (event.password == password) {
      confirmPassword = event.password;
      emit(state.copyWith(
        validConfirmPassword: true,
        isDisable: false,
      ));

      // btn enable disable condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(
        validConfirmPassword: false,
        isDisable: true,
      ));
    }
    if (event.password != null) {
      emit(state.copyWith(
        isFailedRegister: false,
      ));
    }
  }

  void _birthDate(
      BirthDateChangeEvent event, Emitter<RegisterState> emit) async {
    if (event.birthday != null && event.birthday!.length >= 8) {
      dateOfBirth = event.birthday;
      emit(state.copyWith(birthDate: true, isDisable: false));

      //button enable disable condition
      // btn enable disable condition

      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(birthDate: false, isDisable: true));
    }
    if (event.birthday != null) {
      emit(state.copyWith(
        isFailedRegister: false,
      ));
    }
  }

  void _gender(GenderChangeEvent event, Emitter<RegisterState> emit) async {
    if (event.gender != null && event.gender!.length >= 4) {
      gender = event.gender;
      emit(state.copyWith(validGender: true, isDisable: false));

      // btn enable disable condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(validGender: false, isDisable: true));
    }
    if (event.gender != null) {
      emit(state.copyWith(
        isFailedRegister: false,
      ));
    }
  }

  void _filePicker(FilePickerEvent event, Emitter<RegisterState> emit) async {
    if (event.file != null) {}
  }

  buttonEnableDisable(Emitter<RegisterState> emit) {
    if (state.validEmail == true &&
        state.validPassword == true &&
        state.isName == true &&
        state.validGender == true &&
        state.birthDate == true &&
        state.validConfirmPassword == true &&
        isEmail != null &&
        password != null &&
        confirmPassword != null &&
        dateOfBirth != null &&
        name != null &&
        gender != null) {
      emit(state.copyWith(
        isDisable: false,
      ));
    } else {
      emit(state.copyWith(
        isDisable: true,
      ));
    }
  }
}
