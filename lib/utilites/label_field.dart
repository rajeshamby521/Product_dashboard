import 'package:desktop_app_demo/util/Responsive.dart';
import 'package:flutter/material.dart';

class LabelFieldWidget extends StatefulWidget {
  const LabelFieldWidget(
      {Key? key,
      this.textStyle,
      this.iconColor,
      this.icon,
      this.textLabel,
      this.iconSize})
      : super(key: key);
  final TextStyle? textStyle;
  final String? textLabel;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  _LabelFieldWidgetState createState() => _LabelFieldWidgetState();
}

class _LabelFieldWidgetState extends State<LabelFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: widget.iconSize ??
                Responsive().getResponsiveValue(
                    forLargeScreen: 40.0,
                    forMobileScreen: 40.0,
                    forMediumScreen: 35.0,
                    forShortScreen: 32.0,
                    forMobLandScapeMode: 20.0,
                    context: context),
            color: widget.iconColor,
            semanticLabel: 'Log Out',
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            widget.textLabel!,
            style: widget.textStyle,
          ),
        ]);
  }
}
