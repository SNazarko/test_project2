part of 'search_cubit.dart';


class SearchState extends Equatable {
  const SearchState({
    this.status = BlocStatus.initial,
    this.wifiList = const [],
    this.newWifiList = const [],
    this.online  = const [],
    this.suspicious = '0',
    this.secure = '0',
    this.error,

  });

  final BlocStatus status;
  final List <CustomWifiPointModel> wifiList;
  final List <CustomWifiPointModel> newWifiList;
  final List <CustomWifiPointModel> online;
  final String suspicious;
  final String secure;
  final String? error;


  @override
  List<Object?> get props =>
      [
        online,
        wifiList,
        suspicious,
        secure,
        status,
        newWifiList,
        error,
      ];

  SearchState copyWith({
    BlocStatus? status,
    List<CustomWifiPointModel>? wifiList,
    List<CustomWifiPointModel>? newWifiList,
    List<CustomWifiPointModel>? online,
    String? suspicious,
    String? secure,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      wifiList: wifiList ?? this.wifiList,
      newWifiList: newWifiList ?? this.newWifiList,
      online: online ?? this.online,
      suspicious: suspicious ?? this.suspicious,
      secure: secure ?? this.secure,
      error: error ?? this.error,
    );
  }
}