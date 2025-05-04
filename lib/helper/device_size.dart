import 'package:flutter/cupertino.dart';

class DeviceSize {
  const DeviceSize();
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
