
import 'package:test_project/presentation/theme/app_icons.dart';

import '../../domain/models/custom_blue_point_model.dart';
import '../../domain/models/custom_wifi_point_model.dart';

final class Func {
  static ({
    List<CustomWifiPointModel> commonItems,
    Set<CustomWifiPointModel> differentItems,
    List<CustomWifiPointModel> newItems,
    List<CustomWifiPointModel> newList,
  }) compareListWifi(List<CustomWifiPointModel> wifiList,
      List<CustomWifiPointModel> wifiListCache) {
    List<CustomWifiPointModel> commonItems = [];
    List<CustomWifiPointModel> newItems = [];
    Set<CustomWifiPointModel> differentItems = {};

    for (var wifiPoint in wifiList) {
      if (wifiListCache.any((element) => element.bssid == wifiPoint.bssid)) {
        commonItems.add(wifiPoint);
      } else {
        differentItems.add(wifiPoint);
        newItems.add(wifiPoint);
      }
    }
    for (var wifiPoint in wifiListCache) {
      if (!wifiList.any((element) => element.bssid == wifiPoint.bssid)) {
        differentItems.add(wifiPoint);
      }
    }
    final List<CustomWifiPointModel> newList =
        List<CustomWifiPointModel>.from(commonItems + differentItems.toList());
    return (
      commonItems: commonItems,
      differentItems: differentItems,
      newList: newList,
      newItems: newItems,
    );
  }

  static ({
    List<CustomBluePointModel> commonItems,
    Set<CustomBluePointModel> differentItems,
    List<CustomBluePointModel> newItems,
    List<CustomBluePointModel> newList,
  }) compareListBlue(List<CustomBluePointModel> blueList,
      List<CustomBluePointModel> blueListCache) {
    List<CustomBluePointModel> commonItems = [];
    List<CustomBluePointModel> newItems = [];
    Set<CustomBluePointModel> differentItems = {};

    for (var bluePoint in blueList) {
      if (blueListCache
          .any((element) => element.remoteId == bluePoint.remoteId)) {
        commonItems.add(bluePoint);
      } else {
        differentItems.add(bluePoint);
        newItems.add(bluePoint);
      }
    }
    for (var bluePoint in blueListCache) {
      if (!blueList.any((element) => element.remoteId == bluePoint.remoteId)) {
        differentItems.add(bluePoint);
      }
    }
    final List<CustomBluePointModel> newList =
        List<CustomBluePointModel>.from(commonItems + differentItems.toList());
    return (
      commonItems: commonItems,
      differentItems: differentItems,
      newList: newList,
      newItems: newItems,
    );
  }

  static String getIconWifi(String data) {
    final bool isRouter = data.toLowerCase().contains('link') ||
        data.toUpperCase().contains('2.4');
    final bool isNetworkDevise = data.toLowerCase().contains('ghz');
    if (isRouter) {
      return AppIcons.wifi;
    } else if (isNetworkDevise) {
      return AppIcons.network;
    } else {
      return AppIcons.laptop;
    }
  }

  static String getIconBlue(String data) {
    final bool isTv = data.toLowerCase().contains('tv');
    final bool isMobile = data.toLowerCase().contains('mob');
    final bool isMusic = data.toLowerCase().contains('jbl');
    if (isTv) {
      return AppIcons.tv;
    } else if (isMobile) {
      return AppIcons.mobile;
    } else if (isMusic) {
      return AppIcons.mp3;
    } else {
      return AppIcons.bluetooth;
    }
  }

  static String getName(
      CustomWifiPointModel? modelWifi, CustomBluePointModel? modelBlue) {
    if (modelWifi != null) {
      if (modelWifi.ssid.isNotEmpty) {
        return modelWifi.ssid;
      } else {
        return 'no title';
      }
    } else {
      if (modelBlue!.localName.isNotEmpty) {
        return modelBlue.localName;
      } else {
        return 'no title';
      }
    }
  }

}
