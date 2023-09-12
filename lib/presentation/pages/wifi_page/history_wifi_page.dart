import 'package:flutter/material.dart';

import '../../../domain/models/custom_wifi_point_model.dart';
import '../../utils/converter.dart';
import '../../widgets/appbar_widgets/appbat_secondary.dart';
import '../../widgets/list_item.dart';

class HistoryWifiPage extends StatefulWidget {
  const HistoryWifiPage({Key? key, this.wifiList}) : super(key: key);
  static const routeName = '/wifi_page/history_wifi_page';
  final String? wifiList;

  @override
  State<HistoryWifiPage> createState() => _HistoryWifiPageState();
}

class _HistoryWifiPageState extends State<HistoryWifiPage> {
  List<CustomWifiPointModel> _wifiList = [];

  @override
  void initState() {
    _wifiList = CustomWifiPointModel.fromStringWiFiPointList(
      widget.wifiList ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBatSecondary(
        title: 'Devices Wifi History',
        iconInfo: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: _wifiList.isNotEmpty

        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                itemCount: _wifiList.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    modelWifi: _wifiList[index], isOnline: false,
                  );
                },
              ),
            ),
          ],
        )
        : Center(
          child: Text('History is empty',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
        ,
      ),
    );
  }
}
