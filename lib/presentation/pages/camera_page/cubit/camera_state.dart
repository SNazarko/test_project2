part of 'camera_cubit.dart';

class CameraState extends Equatable {
  const CameraState ( {
    this.status = BlocStatus.loaded,
    this.color,
  });

  final BlocStatus status;
  final Color? color;


  @override

  List<Object?> get props => [
    status,
    color,
  ];

  CameraState copyWith({
    BlocStatus? status,
    Color? color,
  }) {
    return CameraState(
      status: status ?? this.status,
      color: color ?? this.color,
    );
  }
}

