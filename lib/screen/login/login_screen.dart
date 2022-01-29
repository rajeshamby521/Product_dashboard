import 'package:desktop_app_demo/route/route_name.dart';
import 'package:desktop_app_demo/util/responsive.dart';
import 'package:desktop_app_demo/util/colors_constant.dart';
import 'package:desktop_app_demo/utilites/material_button.dart';
import 'package:desktop_app_demo/utilites/style_extension.dart';
import 'package:desktop_app_demo/utilites/text_field_widget.dart';
import 'package:desktop_app_demo/utilites/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  TextEditingController emailControl = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state.isSuccessLogin == true) {
            Navigator.pushNamed(context, RoutesName.PRODUCT_LIST_PAGE);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: Responsive().getResponsiveValue(
                          forLargeScreen: true,
                          forMobileScreen: false,
                          forMediumScreen: true,
                          forShortScreen: false,
                          forMobLandScapeMode: false,
                          context: context),
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF3366FF),
                                  Color(0xFF00CCFF),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFieldWidget(
                                  controller: emailControl,
                                  cursorColors: Colors.black,
                                  textStyle: textStyle(
                                      Colors.black54, FontWeight.w600, 18),
                                  hintTextStyle: textStyle(
                                      Colors.grey, FontWeight.w600, 16),
                                  placeholderText: 'Enter Your Email',
                                  errorText: state.validEmail == false
                                      ? 'Please enter valid email'
                                      : null,
                                  maxLine: 1,
                                  onChanged: (value) {
                                    context
                                        .read<LoginBloc>()
                                        .add(EmailChangeEvent(value));
                                  }),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFieldWidget(
                                obscureText: true,
                                controller: password,
                                cursorColors: Colors.black,
                                textStyle: textStyle(
                                    Colors.black54, FontWeight.w600, 18),
                                hintTextStyle:
                                    textStyle(Colors.grey, FontWeight.w600, 16),
                                placeholderText: 'Enter Your Password',
                                errorText: state.validPassword == false
                                    ? ' Password length must be greater than 7'
                                    : null,
                                maxLine: 1,
                                textInputType: TextInputType.number,

                                onChanged: (value) {
                                  context
                                      .read<LoginBloc>()
                                      .add(PasswordChangeEvent(value));
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MaterialButtonWidget(
                                width: 350,
                                child: state.isLoading == true
                                    ? const SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'Login',
                                        style: textStyle(
                                            Colors.white, FontWeight.w600, 18),
                                      ),
                                onTap: state.disable == false
                                    ? () => {
                                          context.read<LoginBloc>().add(
                                              UserLoginEvent(
                                                  email: emailControl.text,
                                                  password: password.text))
                                        }
                                    : null,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Do not have an account ?",
                                    style: textStyle(
                                        Colors.black, FontWeight.w500, 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RoutesName.REGISTER_PAGE);
                                    },
                                    child: Text(
                                      " SingUp here",
                                      style: textStyle(
                                          ColorsConstant.APP_PRIMARY_COLOR,
                                          FontWeight.w600,
                                          18),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              TextWidget(
                                text: state.isFailedLogin == true
                                    ? ' Invalid email or password '
                                    : '',
                                style:
                                    textStyle(Colors.red, FontWeight.w600, 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
