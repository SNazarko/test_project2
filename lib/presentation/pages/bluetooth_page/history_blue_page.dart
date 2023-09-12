import 'package:flutter/material.dart';

import '../../../domain/models/custom_blue_point_model.dart';
import '../../widgets/appbar_widgets/appbat_secondary.dart';
import '../../widgets/list_item.dart';

class HistoryBluePage extends StatefulWidget {
  const HistoryBluePage({Key? key, this.blueList}) : super(key: key);
  static const routeName = '/bluetooth_page/history_blue_page';
  final String? blueList;

  @override
  State<HistoryBluePage> createState() => _HistoryBluePageState();
}

class _HistoryBluePageState extends State<HistoryBluePage> {
  List<CustomBluePointModel> _blueList = [];

  @override
  void initState() {
    _blueList = CustomBluePointModel.fromStringBluePointList(
      widget.blueList ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBatSecondary(
        title: 'Devices Bluetooth History',
        iconInfo: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: _blueList.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      itemCount: _blueList.length,
                      itemBuilder: (context, index) {
                        return ListItem(
                          isOnline: false,
                          modelBlue: _blueList[index],
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  'History is empty',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
      ),
    );
  }
}
