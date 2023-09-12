import '../models/custom_blue_point_model.dart';
import '../models/custom_wifi_point_model.dart';

abstract interface class IStorageRepository {
  Future<
      ({
        bool isSuccess,
        List<CustomWifiPointModel> getList,
        String? error,
      })> getFromCacheWifi();

  void saveToCacheWifi({
    required List<CustomWifiPointModel> data,
  });
  Future<
      ({
        bool isSuccess,
        List<CustomBluePointModel> getList,
        String? error,
      })> getFromCacheBlue();

  void saveToCacheBlue({
    required List<CustomBluePointModel> data,
  });
}
