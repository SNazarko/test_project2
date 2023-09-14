// ignore_for_file: deprecated_member_use

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/presentation/theme/app_fonts.dart';
import 'package:test_project/presentation/theme/app_icons.dart';
import 'package:test_project/presentation/widgets/main_button.dart';

import '../../../domain/models/custom_wifi_point_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/func.dart';
import '../../widgets/appbar_widgets/appbat_secondary.dart';
import '../../widgets/term.dart';

class DetailInfoWifiPage extends StatefulWidget {
  const DetailInfoWifiPage({
    Key? key,
    this.wifiList,
    this.isSecure,
    this.isOnline,
  }) : super(key: key);
  static const routeName = '/search_results_wifi_page/detail_info_wifi_page';
  final String? wifiList;
  final String? isSecure;
  final String? isOnline;

  @override
  State<DetailInfoWifiPage> createState() => _DetailInfoWifiPageState();
}

class _DetailInfoWifiPageState extends State<DetailInfoWifiPage> {
  CustomWifiPointModel? _wifiList;
  @override
  void initState() {
    _wifiList = CustomWifiPointModel.fromStringWiFiPoint(widget.wifiList ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBatSecondary(
        title: 'Devices Wifi Detail',
        iconInfo: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Func.getIconWifi(_wifiList?.ssid ?? ''),
                  width: 75.0,
                  height: 75.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _wifiList?.ssid ?? '',
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                              color: AppColors.text,
                              fontWeight: AppFonts.extraBold,
                            ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 220.0,
                  decoration: const BoxDecoration(
                    color: AppColors.itemList,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          widget.isSecure == 'true'
                              ? AppIcons.shieldCheck
                              : AppIcons.shieldCross,
                          width: 40.0,
                          height: 40.0,
                          color: widget.isSecure == 'true'
                              ? AppColors.green
                              : AppColors.red,
                        ),
                      ),
                      Text(
                        'No danger detected',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: AppFonts.extraBold,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Term(
                          text1: 'Status - ',
                          text2:
                              widget.isOnline == 'true' ? 'Online' : 'Offline',
                          icon: AppIcons.dot,
                          iconColors: widget.isOnline == 'true'
                              ? AppColors.green
                              : AppColors.textGrey,
                        ),
                      ),
                      Term(
                        onTap: () {
                          Clipboard.setData(
                              const ClipboardData(text: '192.168.1.1'));
                        },
                        text1: 'IP Adress : ',
                        text2: '192.168.1.1',
                        icon: AppIcons.copy,
                        size: 15.0,
                        iconColors: AppColors.textGrey,
                      ),
                      Term(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: _wifiList!.bssid));
                        },
                        text1: 'MAC Adress : ',
                        text2: _wifiList!.bssid,
                        icon: AppIcons.copy,
                        size: 15.0,
                        iconColors: AppColors.textGrey,
                      ),
                      Term(
                        onTap: () {
                          Clipboard.setData(
                              const ClipboardData(text: 'Unknown'));
                        },
                        text1: 'Hostname : ',
                        text2: 'Unknown',
                        icon: AppIcons.copy,
                        size: 15.0,
                        iconColors: AppColors.textGrey,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 8.0),
                  child: Text(
                    'Tapping each link below will attempt to open its login screen so you can identify the device.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                  ),
                ),
                MainButton(
                    text: 'Connect',
                    onTap: () async {
                      AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
