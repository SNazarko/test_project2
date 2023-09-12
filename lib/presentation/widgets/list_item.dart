// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

import '../../domain/models/custom_blue_point_model.dart';
import '../../domain/models/custom_wifi_point_model.dart';
import '../pages/wifi_page/detail_info_wifi_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../theme/app_icons.dart';
import '../utils/func.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      this.modelBlue,
      this.isSecure = true,
      required this.isOnline,
      this.modelWifi})
      : super(key: key);
  final CustomBluePointModel? modelBlue;
  final CustomWifiPointModel? modelWifi;
  final bool isSecure;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: modelWifi != null
          ? () => Routemaster.of(context)
                  .push(DetailInfoWifiPage.routeName, queryParameters: {
                'wifiList': CustomWifiPointModel.toStringCustomWiFiPoint(modelWifi),
                'isSecure': isSecure ? 'true' : 'false',
                'isOnline': isOnline ? 'true' : 'false',
              })
          : () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
              color: isSecure ? AppColors.itemList : AppColors.suspicious,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: SvgPicture.asset(
                            modelBlue != null
                                ? Func.getIconBlue(modelBlue?.localName ?? '')
                                : Func.getIconWifi(modelWifi?.ssid ?? ''),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0).copyWith(
                            left: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Func.getName(modelWifi, modelBlue),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: AppFonts.bold,
                                    ),
                              ),
                              Text(
                                modelWifi?.bssid ?? modelBlue?.remoteId ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isOnline
                        ? Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, left: 20.0),
                            child: SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: SvgPicture.asset(
                                AppIcons.dot,
                                fit: BoxFit.fitWidth,
                                color: AppColors.green,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                modelBlue != null
                    ? Text(
                        '${modelBlue!.rssi.toString().replaceAll('-', '')}m.')
                    : SvgPicture.asset(
                        isSecure ? AppIcons.shieldCheck : AppIcons.shieldCross,
                        width: 30.0,
                        height: 30.0,
                        color: isSecure ? AppColors.green : AppColors.red,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
