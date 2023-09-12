
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../domain/models/custom_blue_point_model.dart';
import '../../domain/models/custom_wifi_point_model.dart';

final class Converter {
  static List<CustomWifiPointModel> convertToCustomWifiPointList(
      List<WiFiAccessPoint> wifiAccessPoints) {
    List<CustomWifiPointModel> customWifiPoints = [];
    for (WiFiAccessPoint wifiAccessPoint in wifiAccessPoints) {
      customWifiPoints
          .add(CustomWifiPointModel.fromWiFiAccessPoint(wifiAccessPoint));
    }
    return customWifiPoints;
  }

  static List<CustomBluePointModel> convertToCustomBluePointList(
      List<ScanResult> scanResults) {
    List<CustomBluePointModel> customBluePoints = [];
    for (ScanResult scanResult in scanResults) {
      if (scanResult.device.localName.isNotEmpty) {
        customBluePoints
            .add(CustomBluePointModel.fromBlueScanResult(scanResult));
      }
    }
    return customBluePoints;
  }
}
