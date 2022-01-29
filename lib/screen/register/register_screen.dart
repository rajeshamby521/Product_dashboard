import 'package:desktop_app_demo/screen/register/bloc/register_bloc.dart';
import 'package:desktop_app_demo/screen/register/bloc/register_event.dart';
import 'package:desktop_app_demo/screen/register/bloc/register_state.dart';
import 'package:desktop_app_demo/util/Responsive.dart';
import 'package:desktop_app_demo/util/colors_constant.dart';
import 'package:desktop_app_demo/utilites/label_field.dart';
import 'package:desktop_app_demo/utilites/material_button.dart';
import 'package:desktop_app_demo/utilites/style_extension.dart';
import 'package:desktop_app_demo/utilites/text_field_widget.dart';
import 'package:desktop_app_demo/utilites/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc registerBloc = RegisterBloc();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController gender = TextEditingController();

  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => registerBloc,
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccessLogin == true) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const TextWidget(
                  text: 'Register Screen',
                ),
                automaticallyImplyLeading: true,
              ),
              body: Row(
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
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              width: 334,
                              height: 52,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorsConstant.APP_PRIMARY_COLOR,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  var pickedFile = await FilePicker.platform
                                      .pickFiles(type: FileType.image);
                                  file = pickedFile!.files.single;

                                  context
                                      .read<RegisterBloc>()
                                      .add(FilePickerEvent(file));
                                },
                                child: LabelFieldWidget(
                                  textLabel: 'Upload Profile Picture ',
                                  textStyle: textStyle(
                                      Colors.black54, FontWeight.w600, 16),
                                  icon: Icons.drive_folder_upload,
                                  iconColor: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: name,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              placeholderText: 'Enter Your Name',
                              maxLine: 1,
                              errorText: state.isName == false
                                  ? 'Please enter valid name'
                                  : null,
                              onChanged: (value) {
                                context
                                    .read<RegisterBloc>()
                                    .add(NameChangeEvent(value));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: email,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              errorText: state.validEmail == false
                                  ? 'Please enter valid email'
                                  : null,
                              maxLine: 1,
                              placeholderText: 'Enter Your Email',
                              onChanged: (value) {
                                context
                                    .read<RegisterBloc>()
                                    .add(EmailChangeEvent(value));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: password,
                              obscureText: true,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              errorText: state.validPassword == false
                                  ? "Password length must be greater than 7"
                                  : null,
                              maxLine: 1,
                              textInputType: TextInputType.number,
                              placeholderText: 'Enter Password',
                              onChanged: (value) {
                                context
                                    .read<RegisterBloc>()
                                    .add(PasswordChangeEvent(value));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              obscureText: true,
                              controller: confirmPassword,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              errorText: state.validConfirmPassword == false
                                  ? 'Please match password'
                                  : null,
                              textInputType: TextInputType.number,
                              maxLine: 1,
                              placeholderText: 'Enter ConfirmPassword',
                              onChanged: (value) {
                                context
                                    .read<RegisterBloc>()
                                    .add(ConfirmPasswordChangeEvent(value));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: birthDate,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              errorText: state.birthDate == false
                                  ? 'Please enter dob'
                                  : null,
                              maxLine: 1,
                              placeholderText: 'Provide DOB dd-mm-yy ',
                              textInputType: TextInputType.number,
                              onChanged: (value) {
                                context
                                    .read<RegisterBloc>()
                                    .add(BirthDateChangeEvent(value));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: gender,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              errorText: state.validGender == false
                                  ? 'Please enter gender'
                                  : null,
                              maxLine: 1,
                              placeholderText: 'Please Enter Gender ',
                              onChanged: (value) {
                                context
                                    .read<RegisterBloc>()
                                    .add(GenderChangeEvent(value));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MaterialButtonWidget(
                              width: 350,
                              child: state.isLoading == true
                                  ? Text(
                                      'Register',
                                      style: textStyle(
                                          Colors.white, FontWeight.w600, 18),
                                    )
                                  : const CircularProgressIndicator(),
                              onTap: state.isDisable == false
                                  ? () => {
                                        context.read<RegisterBloc>().add(
                                              UserRegisterEvent(
                                                  email: email.text,
                                                  name: name.text,
                                                  password: password.text,
                                                  confirmPassword:
                                                      confirmPassword.text,
                                                  gender: gender.text,
                                                  birthDate: birthDate.text,
                                                  file: file),
                                            )
                                      }
                                  : null,
                            ),
                            TextWidget(
                              text: state.isFailedRegister == true
                                  ? ' The email has already been taken '
                                  : '',
                              style: textStyle(Colors.red, FontWeight.w600, 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
