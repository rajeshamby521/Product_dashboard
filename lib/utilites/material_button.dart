import 'package:desktop_app_demo/util/colors_constant.dart';
import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatefulWidget {
  const MaterialButtonWidget(
      {Key? key, required this.onTap, required this.child, this.width})
      : super(key: key);
  final VoidCallback? onTap;
  final Widget child;
  final double? width;

  @override
  _MaterialButtonWidgetState createState() => _MaterialButtonWidgetState();
}

class _MaterialButtonWidgetState extends State<MaterialButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 70,
      width: widget.width,
      child: MaterialButton(
        onPressed: widget.onTap,
        child: widget.child,
        textColor: Colors.white,
        disabledColor: ColorsConstant.DISABLE_COLOR,
        disabledTextColor: ColorsConstant.TEXT_DISABLE_COLOR,
        color: ColorsConstant.APP_PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
