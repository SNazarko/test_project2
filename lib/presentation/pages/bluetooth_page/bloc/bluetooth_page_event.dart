part of 'bluetooth_page_bloc.dart';

abstract class BluetoothPageEvent extends Equatable {
  const BluetoothPageEvent();
}

class InitBluetoothEvent implements BluetoothPageEvent {
  const InitBluetoothEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class GetDataBluetoothEvent implements BluetoothPageEvent {
  const GetDataBluetoothEvent({
    required this.blueList,
    required this.blueListCache,
  });
  final List<CustomBluePointModel> blueList;
  final List<CustomBluePointModel> blueListCache;

  @override
  List<Object?> get props => [
        blueList,
        blueListCache,
      ];

  @override
  bool? get stringify => true;
}

class GetBlueEvent implements BluetoothPageEvent {
  const GetBlueEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class RecheckBlueEvent implements BluetoothPageEvent {
  const RecheckBlueEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
