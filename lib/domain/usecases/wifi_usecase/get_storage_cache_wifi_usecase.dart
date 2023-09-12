
import '../../models/custom_wifi_point_model.dart';
import '../../repositories/i_storage_repository.dart';

abstract interface class IGetStorageCacheWifiUsecase {
  Future<
      ({
        String? error,
        List<CustomWifiPointModel> getList,
        bool isSuccess,
      })> call();
}

final class GetStorageCacheWifiUsecase implements IGetStorageCacheWifiUsecase {
  final IStorageRepository repository;

  GetStorageCacheWifiUsecase(this.repository);

  @override
  Future<
      ({
        String? error,
        List<CustomWifiPointModel> getList,
        bool isSuccess,
      })> call() async {
    return await repository.getFromCacheWifi();
  }
}
