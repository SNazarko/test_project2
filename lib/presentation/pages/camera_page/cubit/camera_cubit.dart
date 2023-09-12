import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/enums/enums.dart';
import '../../../theme/app_colors.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState());

  Future<void> changeColor(int i) async {
    emit(state.copyWith(status: BlocStatus.loading));
    switch (i) {
      case 0:
        emit(state.copyWith(
          status: BlocStatus.loaded,
          color: AppColors.red.withOpacity(0.7),
        ));
      case 1:
        emit(state.copyWith(
          status: BlocStatus.loaded,
          color: AppColors.green.withOpacity(0.7),
        ));
      case 2:
        emit(state.copyWith(
          status: BlocStatus.loaded,
          color: AppColors.yellow.withOpacity(0.7),
        ));
      case 3:
        emit(state.copyWith(
          status: BlocStatus.loaded,
          color: AppColors.black.withOpacity(0.7),
        ));
      default:
        emit(state.copyWith(
          status: BlocStatus.loaded,
          color: AppColors.red.withOpacity(0.7),
        ));
    }
  }

}
