import 'package:test_project/domain/models/custom_blue_point_model.dart';

import '../../domain/models/custom_wifi_point_model.dart';
import '../../domain/repositories/i_storage_repository.dart';
import '../local_storage/local_storage.dart';

final class StorageRepository implements IStorageRepository {
  final LocalStorage service;

  StorageRepository(
    this.service,
  );

  @override
  Future<
      ({
        String? error,
        List<CustomWifiPointModel> getList,
        bool isSuccess,
      })> getFromCacheWifi() async {
    return await service.getFromCacheWifi();
  }

  @override
  Future<void> saveToCacheWifi({
    required List<CustomWifiPointModel> data,
  }) {
    return service.saveToCacheWifi(data);
  }

  @override
  Future<
      ({
        String? error,
        List<CustomBluePointModel> getList,
        bool isSuccess,
      })> getFromCacheBlue() async {
    return await service.getFromCacheBlue();
  }

  @override
  Future<void> saveToCacheBlue({
    required List<CustomBluePointModel> data,
  }) {
    return service.saveToCacheBlue(data);
  }
}
