part of 'wifi_page_bloc.dart';

abstract class WifiPageEvent extends Equatable {
  const WifiPageEvent();
}


class InitEvent implements WifiPageEvent{
  const InitEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class GetDataEvent implements WifiPageEvent{
  const GetDataEvent({required this.wifiList, required this.wifiListCache, required this.connectModel});
  final List <CustomWifiPointModel> wifiList;
  final List <CustomWifiPointModel> wifiListCache;
  final ConnectModel? connectModel;

  @override
  List<Object?> get props => [wifiList,wifiListCache,connectModel];

  @override
  bool? get stringify => true;
}


class GetWifiEvent implements WifiPageEvent{
  const GetWifiEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class RecheckWifiEvent implements WifiPageEvent{
  const RecheckWifiEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

