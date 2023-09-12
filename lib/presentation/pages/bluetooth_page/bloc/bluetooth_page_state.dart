part of 'bluetooth_page_bloc.dart';

class BluetoothPageState extends Equatable {
  const BluetoothPageState ( {
    this.status = BlocStatus.initial,
    this.blueList = const [],
    this.blueListCache = const [],
    this.angle = 0.0,
    this.totalAngle = 0.0,
    this.error,

  });

  final BlocStatus status;
  final List <CustomBluePointModel> blueList;
  final List <CustomBluePointModel> blueListCache;
  final double angle;
  final double totalAngle;
  final String? error;

  @override

  List<Object?> get props => [
    status,
    blueList,
    blueListCache,
    angle,
    totalAngle,
    error,
  ];

  BluetoothPageState copyWith({
    BlocStatus? status,
    List<CustomBluePointModel>? blueList,
    List<CustomBluePointModel>? blueListCache,
    double? angle,
    double? totalAngle,
    String? error,
  }) {
    return BluetoothPageState(
      status: status ?? this.status,
      blueList: blueList ?? this.blueList,
      blueListCache: blueListCache ?? this.blueListCache,
      angle: angle ?? this.angle,
      totalAngle: totalAngle ?? this.totalAngle,
      error: error ?? this.error,
    );
  }
}


