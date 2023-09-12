import '../../models/custom_blue_point_model.dart';
import '../../repositories/i_storage_repository.dart';

abstract interface class ISaveStorageCacheBlueUsecase {
  call({
    required List<CustomBluePointModel> data,
  });
}

final class SaveStorageCacheBlueUsecase
    implements ISaveStorageCacheBlueUsecase {
  final IStorageRepository repository;

  SaveStorageCacheBlueUsecase(this.repository);

  @override
  call({
    required List<CustomBluePointModel> data,
  }) {
    return repository.saveToCacheBlue(
      data: data,
    );
  }
}
