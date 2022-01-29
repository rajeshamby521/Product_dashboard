import 'package:flutter/material.dart';

class Responsive {
  // function reponsible for providing value according to screensize
  getResponsiveValue(
      {dynamic forShortScreen,
      dynamic forMediumScreen,
      dynamic forLargeScreen,
      dynamic forMobLandScapeMode,
      dynamic forMobileScreen,
      required BuildContext context}) {
    if (isLargeScreen(context)) {
      return forLargeScreen ?? forShortScreen;
    } else if (isMediumScreen(context)) {
      return forMediumScreen ?? forShortScreen ?? forLargeScreen;
    } else if (isDeviceScreen(context)) {
      return forMobileScreen ?? forMediumScreen ?? forShortScreen;
    } else if (isSmallDeviceScreen(context) && isLandScapeMode(context)) {
      return forMobLandScapeMode ?? forShortScreen;
    } else {
      return forShortScreen;
    }
  }

  isLandScapeMode(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return true;
    } else {
      return false;
    }
  }

  static bool isLargeScreen(BuildContext context) {
    return getWidth(context) > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return getWidth(context) > 576 && getWidth(context) < 1200;
  }

  static bool isDeviceScreen(BuildContext context) {
    return getWidth(context) >= 576;
  }

  static bool isSmallDeviceScreen(BuildContext context) {
    return getWidth(context) < 576;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
