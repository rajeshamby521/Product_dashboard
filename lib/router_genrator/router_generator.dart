import 'package:desktop_app_demo/model/product.dart';
import 'package:desktop_app_demo/route/route_name.dart';
import 'package:desktop_app_demo/router_genrator/generate_route_page.dart';
import 'package:desktop_app_demo/screen/add_product/add_product_screen.dart';
import 'package:desktop_app_demo/screen/luncher_page.dart';
import 'package:desktop_app_demo/screen/login/login_screen.dart';
import 'package:desktop_app_demo/screen/product_detail/product_detail_screen.dart';
import 'package:desktop_app_demo/screen/product_list/product_list_screen.dart';
import 'package:desktop_app_demo/screen/register/register_screen.dart';
import 'package:flutter/cupertino.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.LOGIN_PAGE:
        return GeneratePageRoute(
            widget: const LoginScreen(), routeName: settings.name!);
      case RoutesName.REGISTER_PAGE:
        return GeneratePageRoute(
            widget: const RegisterScreen(), routeName: settings.name!);
      case RoutesName.PRODUCT_LIST_PAGE:
        return GeneratePageRoute(
            widget: const ProductListScreen(), routeName: settings.name!);
      case RoutesName.PRODUCT_PAGE:
        List<dynamic> args = settings.arguments as List;

          return GeneratePageRoute(
              widget: ProductDetailScreen(id: args[0],callBack: args[1],
              ),
              routeName: settings.name!);


      case RoutesName.ADD_PRODUCT_PAGE:
        List<dynamic> args = settings.arguments as List;
        return GeneratePageRoute(
            widget: AddProductScreen(
              product: args[0],
              callBack: args[1],
            ),
            routeName: settings.name!);
      default:
        return GeneratePageRoute(
            widget: const LaunchScreen(), routeName: settings.name!);
    }
  }
}
