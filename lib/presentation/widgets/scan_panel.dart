import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/constants.dart';
import 'main_button.dart';

class ScanPanel extends StatelessWidget {
  const ScanPanel(
      {Key? key,
      required this.start,
      required this.recheck,
      this.wifiName,
      this.wifiIP,
        this.suspicious})
      : super(key: key);
  final dynamic Function() start;
  final dynamic Function() recheck;
  final String? wifiName;
  final String? wifiIP;
  final String? suspicious;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kHeightScanPanel,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suspicious Devices: $suspicious',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  if(wifiName != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Connect to Wi-fi: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      Text(
                        wifiName?.replaceAll('"', '').replaceAll('"', '') ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  if(wifiIP != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Local IP: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        wifiIP ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(children: [
              MainButton(
                text:  wifiName != null ? 'Start Scanning' : 'View Results',
                onTap: start,
              ),
              MainButton(
                setSecondColors: true,
                text: 'Recheck',
                onTap: recheck,
              ),
            ],),

          ],
        ),
      ),
    );
  }
}
