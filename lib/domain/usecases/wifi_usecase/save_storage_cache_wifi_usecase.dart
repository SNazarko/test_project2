

import '../../models/custom_wifi_point_model.dart';
import '../../repositories/i_storage_repository.dart';

abstract interface class ISaveStorageCacheWifiUsecase {
  call({
    required List<CustomWifiPointModel> data,
  });
}

final class SaveStorageCacheWifiUsecase implements ISaveStorageCacheWifiUsecase {
  final IStorageRepository repository;

  SaveStorageCacheWifiUsecase(this.repository);

  @override
  call({
    required List<CustomWifiPointModel> data,
  }) {
    return repository.saveToCacheWifi(
      data: data,
    );
  }
}
