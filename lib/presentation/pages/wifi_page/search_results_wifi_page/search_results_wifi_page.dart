// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/presentation/theme/app_colors.dart';
import 'package:test_project/presentation/theme/app_icons.dart';

import '../../../../domain/models/custom_wifi_point_model.dart';
import '../../../widgets/appbar_widgets/appbat_secondary.dart';
import '../../../widgets/list_item.dart';
import '../../../widgets/title_item.dart';
import 'cubit/search_cubit.dart'as cubit;
import 'package:test_project/dependency_injection.dart' as di;

class SearchResultsWifiPage extends StatefulWidget {
  const SearchResultsWifiPage({
    Key? key,
    required this.wifiList,
    this.wifiListCache,
  }) : super(key: key);
  static const routeName = '/search_results_wifi_page';
  final String? wifiList;
  final String? wifiListCache;


  @override
  State<SearchResultsWifiPage> createState() => _SearchResultsWifiPageState();
}

class _SearchResultsWifiPageState extends State<SearchResultsWifiPage> {
  final cubit.SearchCubit searchCubit = di.getIt.get();
  List<CustomWifiPointModel> _wifiList = [];
  List<CustomWifiPointModel> _wifiListCache = [];
  @override
  void initState() {
    _wifiList = CustomWifiPointModel.fromStringWiFiPointList(
      widget.wifiList ?? '',
    );
    _wifiListCache = CustomWifiPointModel.fromStringWiFiPointList(
      widget.wifiListCache ?? '',
    );
    searchCubit.init(_wifiList, _wifiListCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cubit.SearchCubit, cubit.SearchState>(
      bloc: searchCubit,
  builder: (context, state) {
    return Scaffold(
      appBar: const AppBatSecondary(
        title: 'Devices Found',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleItem(
            text:
                'Suspicious Devises - ${state.suspicious}',
            icon: AppIcons.shieldCross,
            color: AppColors.red,
          ),
          TitleItem(
            text:
                'Secure Devises - ${state.secure}',
            icon: AppIcons.shieldCross,
            color: AppColors.green,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              itemCount: state.wifiList.length,
              itemBuilder: (context, index) {
                return ListItem(
                  modelWifi: state.wifiList[index],
                  isSecure: !state.newWifiList
                      .any(
                          (element) => element.bssid == state.wifiList[index].bssid),
                  isOnline: state.online
                      .any(
                          (element) => element.bssid == state.wifiList[index].bssid),
                );
              },
            ),
          ),
        ],
      ),
    );
  },
);
  }
}

