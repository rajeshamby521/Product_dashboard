import 'package:desktop_app_demo/util/colors_constant.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String text);

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {Key? key,
      this.controller,
      this.hintTextStyle,
      required this.placeholderText,
      this.textStyle,
      this.errorText,
      this.errorTextStyle,
      this.onChanged,
      this.cursorColors,
      this.textInputType,
      this.maxLine,
      this.obscureText = false})
      : super(key: key);
  final TextEditingController? controller;
  final StringCallback? onChanged;
  final String? placeholderText;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Color? cursorColors;
  final bool obscureText;
  final int? maxLine;
  final TextInputType? textInputType;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      width: 350,
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsConstant.APP_PRIMARY_COLOR,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsConstant.APP_PRIMARY_COLOR,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsConstant.APP_PRIMARY_COLOR,
              width: 2,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsConstant.APP_PRIMARY_COLOR,
              width: 2,
            ),
          ),
          hintText: widget.placeholderText,
          hintStyle: widget.hintTextStyle,
          errorText: widget.errorText,
          errorStyle: widget.errorTextStyle,
        ),
        style: widget.textStyle,
        cursorColor: widget.cursorColors,
        onChanged: widget.onChanged,
        maxLines: widget.maxLine,
        keyboardType: widget.textInputType,
      ),
    );
  }
}
