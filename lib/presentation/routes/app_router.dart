import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../pages/bluetooth_page/bluetooth_page.dart';
import '../pages/bluetooth_page/history_blue_page.dart';
import '../pages/bluetooth_page/search_results_blue_page/search_results_blue_page.dart';
import '../pages/camera_page/camera_page.dart';
import '../pages/guide_page/guide_page.dart';
import '../pages/main_page.dart';
import '../pages/wifi_page/detail_info_wifi_page.dart';
import '../pages/wifi_page/history_wifi_page.dart';
import '../pages/wifi_page/search_results_wifi_page/search_results_wifi_page.dart';
import '../pages/wifi_page/wifi_page.dart';
import '../pages/settings_page/settings_page.dart';

class AppRouter {
  AppRouter._();

  static final routes = RouteMap(
    routes: {
      MainPage.routeName: (_) => const TabPage(
            child: MainPage(),
            paths: [
              WifiPage.routeName,
              BluetoothPage.routeName,
              GuidePage.routeName,
              SettingsPage.routeName,
            ],
          ),
      WifiPage.routeName: (_) => MaterialPage(
            child: WifiPage(),
          ),
      SearchResultsWifiPage.routeName: (info) {
        final wifiList = info.queryParameters['wifiList'] ?? '';
        final wifiListCache = info.queryParameters['wifiListCache'] ?? '';
        return MaterialPage(
          child: SearchResultsWifiPage(
            wifiList: wifiList,
            wifiListCache: wifiListCache,
          ),
        );
      },
      SearchResultsBluePage.routeName: (info) {
        final blueList = info.queryParameters['blueList'] ?? '';
        final blueListCache = info.queryParameters['blueListCache'] ?? '';
        return MaterialPage(
          child: SearchResultsBluePage(
            blueList: blueList,
            blueListCache: blueListCache,
          ),
        );
      },
      DetailInfoWifiPage.routeName: (info) {
        final wifiList = info.queryParameters['wifiList'] ?? '';
        final isSecure = info.queryParameters['isSecure'] ?? '';
        final isOnline = info.queryParameters['isOnline'] ?? '';
        return MaterialPage(
          child: DetailInfoWifiPage(
            wifiList: wifiList,
            isSecure: isSecure,
            isOnline: isOnline,
          ),
        );
      },

      HistoryWifiPage.routeName: (info) {
        final wifiList = info.queryParameters['wifiList'] ?? '';
        return MaterialPage(
          child: HistoryWifiPage(
            wifiList: wifiList,
          ),
        );
      },
      HistoryBluePage.routeName: (info) {
        final blueList = info.queryParameters['blueList'] ?? '';
        return MaterialPage(
          child: HistoryBluePage(
            blueList: blueList,
          ),
        );
      },
      CameraPage.routeName: (_) => const MaterialPage(
            child: CameraPage(),
          ),
      BluetoothPage.routeName: (_) => const MaterialPage(
            child: BluetoothPage(),
          ),
      GuidePage.routeName: (_) => const MaterialPage(
            child: GuidePage(),
          ),
      SettingsPage.routeName: (_) => const MaterialPage(
            child: SettingsPage(),
          ),
    },
  );
}
