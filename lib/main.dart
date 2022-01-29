import 'dart:io';

import 'package:desktop_app_demo/route/route_name.dart';
import 'package:desktop_app_demo/router_genrator/router_generator.dart';
import 'package:desktop_app_demo/screen/luncher_page.dart';
import 'package:desktop_app_demo/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RoutesName.INITIAL_PAGE,
    );
  }
}
