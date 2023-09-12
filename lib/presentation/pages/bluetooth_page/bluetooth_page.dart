import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test_project/dependency_injection.dart' as di;
import 'package:test_project/presentation/pages/bluetooth_page/search_results_blue_page/search_results_blue_page.dart';
import '../../../domain/enums/enums.dart';
import '../../../domain/models/custom_blue_point_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/func.dart';
import '../../widgets/appbar_widgets/appbar_main.dart';
import '../../widgets/radar_widget.dart';
import '../../widgets/scan_panel.dart';
import 'bloc/bluetooth_page_bloc.dart' as bloc;
import 'bloc/bluetooth_page_bloc.dart';
import 'history_blue_page.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);
  static const routeName = '/bluetooth_page';

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final bloc.BluetoothPageBloc bluePageBloc = di.getIt.get();
  Routemaster? _route;
  @override
  void initState() {
    bluePageBloc.add(const InitBluetoothEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = Routemaster.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<bloc.BluetoothPageBloc, bloc.BluetoothPageState>(
      bloc: bluePageBloc,
      builder: (context, state) {
        if (state.status == BlocStatus.loaded) {
          return Scaffold(
            backgroundColor: AppColors.blue,
            appBar: AppBarMain(
              onTap: () => _route?.push(HistoryBluePage.routeName, queryParameters: {
                'blueList': CustomBluePointModel.toStringBluePointList(
                    state.blueListCache),
              }),
            ),
            body: BlocListener<bloc.BluetoothPageBloc, bloc.BluetoothPageState>(
              bloc: bluePageBloc,
              listener: (context, state) {
                if (state.status == BlocStatus.nextRoute) {
                  bluePageBloc
                      .add(const RecheckBlueEvent());
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _route?.push(
                        SearchResultsBluePage.routeName,
                        queryParameters: {
                          'blueList': CustomBluePointModel.toStringBluePointList(
                              state.blueList),
                          'blueListCache':
                          CustomBluePointModel.toStringBluePointList(
                                  state.blueListCache),
                        });
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadarWidget(
                    angle: state.angle,
                    isBlue: true,
                  ),
                  ScanPanel(
                    start: () => bluePageBloc.add(
                          const GetBlueEvent(),
                        ),
                    recheck: () => bluePageBloc.add(
                          const RecheckBlueEvent(),
                        ),
                    suspicious: Func.compareListBlue(
                            state.blueList, state.blueListCache)
                        .newItems
                        .length
                        .toString(),
                  )
                ],
              ),
            ),
          );
        }
        if (state.status == BlocStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == BlocStatus.error) {
          return Center(
            child: Text(state.error!),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
