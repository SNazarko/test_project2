// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/custom_blue_point_model.dart';
import '../../../widgets/appbar_widgets/appbat_secondary.dart';
import '../../../widgets/list_item.dart';
import 'package:test_project/dependency_injection.dart' as di;


import 'cubit/search_blue_cubit.dart' as cubit;

class SearchResultsBluePage extends StatefulWidget {
  const SearchResultsBluePage({
    Key? key,
    required this.blueList,
    this.blueListCache,
  }) : super(key: key);
  static const routeName = '/search_results_blue_page';
  final String? blueList;
  final String? blueListCache;

  @override
  State<SearchResultsBluePage> createState() => _SearchResultsBluePageState();
}

class _SearchResultsBluePageState extends State<SearchResultsBluePage> {
  final cubit.SearchBlueCubit searchBlueCubit = di.getIt.get();
  List<CustomBluePointModel> _blueList = [];
  List<CustomBluePointModel> _blueListCache = [];
  @override
  void initState() {
    _blueList = CustomBluePointModel.fromStringBluePointList(
      widget.blueList ?? '',
    );
    _blueListCache = CustomBluePointModel.fromStringBluePointList(
      widget.blueListCache ?? '',
    );
    searchBlueCubit.init(_blueList, _blueListCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cubit.SearchBlueCubit, cubit.SearchBlueState>(
      bloc: searchBlueCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBatSecondary(
            title: 'Devices Found',
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  itemCount: state.blueList.length,
                  itemBuilder: (context, index) {
                    return ListItem(
                      modelBlue: state.blueList[index],
                      isSecure: !state.newBlueList.any((element) =>
                          element.remoteId == state.blueList[index].remoteId),
                      isOnline: state.online
                          .any(
                              (element) => element.remoteId == state.blueList[index].remoteId),
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
