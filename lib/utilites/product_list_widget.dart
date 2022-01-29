import 'package:desktop_app_demo/utilites/style_extension.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({Key? key, this.textLabelName, this.textProduct})
      : super(key: key);
  final String? textLabelName;
  final String? textProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      Text(
        textLabelName!,
        style: textStyle(Colors.white, FontWeight.bold, 18),
        textAlign: TextAlign.center,
      ),
      Text(
        textProduct!,
        style: textStyle(Colors.white, FontWeight.bold, 16),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}

