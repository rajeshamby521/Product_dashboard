import 'package:desktop_app_demo/Util/shared_prefence_util.dart';
import 'package:desktop_app_demo/api/login_api.dart';
import 'package:desktop_app_demo/model/login_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String? isEmail;
  String? password;
  final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();

  LoginBloc() : super(const LoginState()) {
    on<UserLoginEvent>(_loginUser);
    on<EmailChangeEvent>(_emailValid);
    on<PasswordChangeEvent>(_passwordValid);
  }

  void _loginUser(UserLoginEvent event, Emitter<LoginState> emit) async {
    if (state.validEmail == true && state.validPassword == true) {
      emit(state.copyWith(isSuccessLogin: false, isLoading: true));
      LoginAPI loginAPI = LoginAPI();
      LoginRequest loginRequest = LoginRequest();
      loginRequest.email = event.email;
      loginRequest.password = event.password;
      final user = await loginAPI.loginAPI(loginRequest);
      if (user != null) {
        sharedPreferenceUtil.setString(SharedPreferenceUtil.TOKEN, user.token);
        emit(state.copyWith(
            isSuccessLogin: true, isLoading: true, isFailedLogin: false));
      } else {
        print('inside the failed login');
        emit(state.copyWith(
            isSuccessLogin: false, isLoading: false, isFailedLogin: true));
      }
      emit(state.copyWith(isSuccessLogin: false, isLoading: false));
    } else {
            print('inside the failed login');
      emit(
        state.copyWith(
            isSuccessLogin: false, isLoading: false, isFailedLogin: false),
      );
    }
  }

  void _emailValid(EmailChangeEvent event, Emitter<LoginState> emit) async {
    RegExp email = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

    if (event.email != null && email.hasMatch(event.email!)) {
      isEmail = event.email;
      emit(state.copyWith(
        validEmail: true,
        disable: false,
      ));
      if (state.validEmail == true &&
          state.validPassword == true &&
          isEmail != null &&
          password != null) {
        emit(state.copyWith(
          disable: false,
        ));
      } else {
        emit(state.copyWith(
          disable: true,
        ));
      }
    } else {
      emit(
        state.copyWith(
          validEmail: false,
          disable: true,
        ),
      );
    }
    if (event.email != null) {
      emit(state.copyWith(isFailedLogin: false));
    }
  }

  void _passwordValid(
      PasswordChangeEvent event, Emitter<LoginState> emit) async {
    if (event.password != null && event.password!.length >= 8) {
      password = event.password;
      emit(state.copyWith(validPassword: true, disable: false));

      /// button enable disable condition
      if (state.validEmail == true &&
          state.validPassword == true &&
          isEmail != null &&
          password != null) {
        emit(state.copyWith(
          disable: false,
        ));
      } else {
        emit(state.copyWith(
          disable: true,
        ));
      }
    } else {
      emit(state.copyWith(
        validPassword: false,
        disable: true,
      ));
    }
    if (event.password != null) {
      emit(state.copyWith(isFailedLogin: false));
    }
  }
}
