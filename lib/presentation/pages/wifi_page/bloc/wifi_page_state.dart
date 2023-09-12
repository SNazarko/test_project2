part of 'wifi_page_bloc.dart';

class WifiPageState extends Equatable {
  const WifiPageState ( {
    this.status = BlocStatus.initial,
    this.wifiList = const [],
    this.wifiListCache = const [],
    this.connectModel,
    this.angle = 0.0,
    this.totalAngle = 0.0,
    this.error,
    this.nextRouteName,

  });

  final BlocStatus status;
  final List <CustomWifiPointModel> wifiList;
  final List <CustomWifiPointModel> wifiListCache;
  final ConnectModel? connectModel;
  final double angle;
  final double totalAngle;
  final String? error;
  final String? nextRouteName;

  @override

  List<Object?> get props => [
    status,
    wifiList,
    wifiListCache,
    connectModel,
    angle,
    totalAngle,
    error,
    nextRouteName,
  ];

  WifiPageState copyWith({
    BlocStatus? status,
    List<CustomWifiPointModel>? wifiList,
    List<CustomWifiPointModel>? wifiListCache,
    ConnectModel? connectModel,
    double? angle,
    double? totalAngle,
    String? error,
    String? nextRouteName,
  }) {
    return WifiPageState(
      status: status ?? this.status,
      wifiList: wifiList ?? this.wifiList,
      wifiListCache: wifiListCache ?? this.wifiListCache,
      connectModel: connectModel ?? this.connectModel,
      angle: angle ?? this.angle,
      totalAngle: totalAngle ?? this.totalAngle,
      error: error ?? this.error,
      nextRouteName: nextRouteName ?? this.nextRouteName,
    );
  }
}


