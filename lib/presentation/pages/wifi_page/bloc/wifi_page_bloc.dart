import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:test_project/presentation/utils/converter.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../../domain/enums/enums.dart';

import '../../../../domain/models/connect_model.dart';
import '../../../../domain/models/custom_wifi_point_model.dart';
import '../../../../domain/usecases/wifi_usecase/get_storage_cache_wifi_usecase.dart';
import '../../../../domain/usecases/wifi_usecase/save_storage_cache_wifi_usecase.dart';

part 'wifi_page_event.dart';
part 'wifi_page_state.dart';

class WifiPageBloc extends Bloc<WifiPageEvent, WifiPageState> {
  final IGetStorageCacheWifiUsecase _getStorageCacheWifiUsecase;
  final ISaveStorageCacheWifiUsecase _saveStorageCacheWifiUsecase;
  WifiPageBloc(
    this._getStorageCacheWifiUsecase,
    this._saveStorageCacheWifiUsecase,
  ) : super(const WifiPageState()) {
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
              angle: newAngle = 0.0, totalAngle: totalAngle = 0.0,
            status: BlocStatus.nextRoute,
          ));
        }
      });
    }


    on<InitEvent>((event, emit) async {
      emit(state.copyWith(status: BlocStatus.loading));
      final result = await _getStorageCacheWifiUsecase.call();
      if(!result.isSuccess){
        if (kDebugMode) {
          print(result.error);
        }
      }
      final can =
          await WiFiScan.instance.canGetScannedResults(askPermissions: true);
      if (can == CanGetScannedResults.yes) {
        final info = NetworkInfo();
        final wifiName = await info.getWifiName();
        final wifiIP = await info.getWifiIP();
        ConnectModel? connectModel = ConnectModel(
          wifiName: wifiName,
          wifiIP: wifiIP,
        );
        emit(state.copyWith(status: BlocStatus.loaded));
        final subscription =
            WiFiScan.instance.onScannedResultsAvailable.listen((results) async {
          late List<CustomWifiPointModel> wifiList =
              Converter.convertToCustomWifiPointList(results);
          add(GetDataEvent(
            wifiList: wifiList,
            wifiListCache: result.getList,
            connectModel: connectModel,
          ));
          await _saveStorageCacheWifiUsecase.call(
            data: wifiList,
          );
        });
      } else {
        emit(state.copyWith(status: BlocStatus.loaded));
        AppSettings.openAppSettings();
      }
    });

    on<GetDataEvent>((event, emit) async {
      emit(state.copyWith(
        status: BlocStatus.loaded,
        connectModel: event.connectModel,
        wifiListCache: event.wifiListCache,
        wifiList: event.wifiList,
      ));
    });

    on<GetWifiEvent>((event, emit) async {
      if (timer?.isActive == true) return;
      startTimer(emit);
       await Future.delayed(const Duration(seconds: 7));

    });

    on<RecheckWifiEvent>((event, emit) async {
      stopTimer();
      emit(state.copyWith(
        status: BlocStatus.loaded,
        angle: 0.0,
        totalAngle: 0.0,
      ));
    });
  }
}
