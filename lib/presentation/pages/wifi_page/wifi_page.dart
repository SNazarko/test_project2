import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test_project/domain/enums/enums.dart';
import 'package:test_project/presentation/pages/wifi_page/bloc/wifi_page_bloc.dart'
    as bloc;
import 'package:test_project/presentation/pages/wifi_page/search_results_wifi_page/search_results_wifi_page.dart';
import 'package:test_project/presentation/theme/app_colors.dart';
import 'package:test_project/presentation/widgets/appbar_widgets/appbar_main.dart';
import 'package:test_project/presentation/widgets/scan_panel.dart';
import 'package:test_project/dependency_injection.dart' as di;
import '../../../domain/models/custom_wifi_point_model.dart';
import '../../utils/func.dart';
import '../../widgets/radar_widget.dart';
import 'bloc/wifi_page_bloc.dart';
import 'history_wifi_page.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({Key? key}) : super(key: key);
  static const routeName = '/wifi_page';

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  Routemaster? _route;
  final bloc.WifiPageBloc wifiPageBloc = di.getIt.get();

  @override
  void initState() {
    wifiPageBloc.add( const InitEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = Routemaster.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<bloc.WifiPageBloc, bloc.WifiPageState>(
      bloc: wifiPageBloc,
      builder: (context, state) {
        if (state.status == BlocStatus.loaded) {
          return Scaffold(
            backgroundColor: AppColors.blue,
            appBar: AppBarMain(
              onTap: () => _route
                  ?.push(HistoryWifiPage.routeName, queryParameters: {
                'wifiList': CustomWifiPointModel.toStringWiFiPointList(
                    wifiPageBloc.state.wifiListCache),
              }),
            ),
            body: BlocListener<bloc.WifiPageBloc, bloc.WifiPageState>(
              bloc: wifiPageBloc,
              listener: (context, state) {
                if (state.status == BlocStatus.nextRoute) {
                  wifiPageBloc
                      .add(const RecheckWifiEvent());
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _route?.push(
                        SearchResultsWifiPage.routeName,
                        queryParameters: {
                          'wifiList': CustomWifiPointModel.toStringWiFiPointList(
                              state.wifiList),
                          'wifiListCache':
                          CustomWifiPointModel.toStringWiFiPointList(
                                  state.wifiListCache),
                        });

                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadarWidget(angle: state.angle),
                  ScanPanel(
                    start: () => wifiPageBloc.add(
                          const GetWifiEvent(),
                        ),
                    recheck: () => wifiPageBloc.add(
                          const RecheckWifiEvent(),
                        ),
                    wifiName: state.connectModel?.wifiName,
                    wifiIP: state.connectModel?.wifiIP,
                    suspicious: Func.compareListWifi(
                            state.wifiList, state.wifiListCache)
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
