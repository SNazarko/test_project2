import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../domain/enums/enums.dart';
import '../../../../domain/models/custom_blue_point_model.dart';
import '../../../../domain/usecases/blue_usecase/get_storage_cache_blue_usecase.dart';
import '../../../../domain/usecases/blue_usecase/save_storage_cache_blue_usecase.dart';
import '../../../utils/converter.dart';

part 'bluetooth_page_event.dart';
part 'bluetooth_page_state.dart';

class BluetoothPageBloc extends Bloc<BluetoothPageEvent, BluetoothPageState> {
  final IGetStorageCacheBlueUsecase _getStorageCacheBlueUsecase;
  final ISaveStorageCacheBlueUsecase _saveStorageCacheBlueUsecase;
  BluetoothPageBloc(
    this._getStorageCacheBlueUsecase,
    this._saveStorageCacheBlueUsecase,
  ) : super(const BluetoothPageState()) {
    StreamSubscription subscription;
    Timer? timer;
    void stopTimer() => timer?.cancel();
    void startTimer(emit) {
      timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
        double newAngle = state.angle;
        double totalAngle = state.totalAngle;
        emit(state.copyWith(
            angle: newAngle += 0.1, totalAngle: totalAngle += 0.1));
        if (state.angle > 6) {
          emit(state.copyWith(angle: newAngle = 0.0));
        }
        if (state.totalAngle > 12) {
          stopTimer();
          emit(state.copyWith(
            angle: newAngle = 0.0,
            totalAngle: totalAngle = 0.0,
            status: BlocStatus.nextRoute,
          ));
        }
      });
    }

    on<InitBluetoothEvent>((event, emit) async {
      emit(state.copyWith(status: BlocStatus.loading));
      try {
        final result = await _getStorageCacheBlueUsecase();
        if(!result.isSuccess){
          if (kDebugMode) {
            print(result.error);
          }
        }
        if (await FlutterBluePlus.isAvailable == false) {
          if (kDebugMode) {
            print("Bluetooth not supported by this device");
          }
          return;
        }

        if (Platform.isAndroid) {
          await FlutterBluePlus.turnOn();
        }
        await FlutterBluePlus.adapterState
            .map((s) {

              if (kDebugMode) {
                print('==> $s');
              }
              return s;
            })
            .where((s) => s == BluetoothAdapterState.on)
            .first;

        List<CustomBluePointModel> blueList = [];

        subscription = FlutterBluePlus.scanResults.listen((results) async {
          blueList = Converter.convertToCustomBluePointList(results);
        });
        await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
        await Future.delayed(const Duration(seconds: 1));
        await FlutterBluePlus.stopScan();
        await _saveStorageCacheBlueUsecase.call(data: blueList);
        add(GetDataBluetoothEvent(
          blueList: blueList ,
          blueListCache: result.getList,
        ));
      } catch (e) {
        emit(state.copyWith(status: BlocStatus.loaded));
        if (e is PlatformException) {
          if (e.code == 'startScan') {
            AppSettings.openAppSettings();
          }
        } else {
          if (kDebugMode) {
            print('===> $e');
          }
        }
      }
    });

    on<GetDataBluetoothEvent>((event, emit) async {
      emit(state.copyWith(
        status: BlocStatus.loaded,
        blueList: event.blueList,
        blueListCache: event.blueListCache,
      ));
    });

    on<GetBlueEvent>((event, emit) async {
      if (timer?.isActive == true) return;
      startTimer(emit);
      await Future.delayed(const Duration(seconds: 7));
    });

    on<RecheckBlueEvent>((event, emit) async {
      stopTimer();
      emit(state.copyWith(
        status: BlocStatus.loaded,
        angle: 0.0,
        totalAngle: 0.0,
      ));
    });
  }
}
