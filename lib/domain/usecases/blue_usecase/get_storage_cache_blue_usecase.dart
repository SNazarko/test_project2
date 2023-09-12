import '../../models/custom_blue_point_model.dart';
import '../../repositories/i_storage_repository.dart';

abstract interface class IGetStorageCacheBlueUsecase {
  Future<
      ({
        String? error,
        List<CustomBluePointModel> getList,
        bool isSuccess,
      })> call();
}

final class GetStorageCacheBlueUsecase implements IGetStorageCacheBlueUsecase {
  final IStorageRepository repository;

  GetStorageCacheBlueUsecase(this.repository);

  @override
  Future<
      ({
        String? error,
        List<CustomBluePointModel> getList,
        bool isSuccess,
      })> call() async {
    return await repository.getFromCacheBlue();
  }
}
