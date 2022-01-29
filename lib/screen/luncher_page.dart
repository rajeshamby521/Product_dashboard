import 'dart:async';

import 'package:desktop_app_demo/Util/shared_prefence_util.dart';
import 'package:desktop_app_demo/route/route_name.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), onClose);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void onClose() async {
    final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
    String? token =
        await sharedPreferenceUtil.getString(SharedPreferenceUtil.TOKEN);
    Navigator.pop(context);
    if (token != null) {
      Navigator.pushNamed(context, RoutesName.PRODUCT_LIST_PAGE);
    } else {
      Navigator.pushNamed(context, RoutesName.LOGIN_PAGE);
    }
  }
}
