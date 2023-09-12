import 'package:get_it/get_it.dart';
import 'package:test_project/presentation/pages/bluetooth_page/bloc/bluetooth_page_bloc.dart';
import 'package:test_project/presentation/pages/bluetooth_page/search_results_blue_page/cubit/search_blue_cubit.dart';
import 'package:test_project/presentation/pages/camera_page/cubit/camera_cubit.dart';
import 'package:test_project/presentation/pages/wifi_page/bloc/wifi_page_bloc.dart';
import 'package:test_project/presentation/pages/wifi_page/search_results_wifi_page/cubit/search_cubit.dart';

import 'data/local_storage/local_storage.dart';
import 'data/repositories/storage_repository.dart';
import 'domain/repositories/i_storage_repository.dart';
import 'domain/usecases/blue_usecase/get_storage_cache_blue_usecase.dart';
import 'domain/usecases/wifi_usecase/get_storage_cache_wifi_usecase.dart';
import 'domain/usecases/blue_usecase/save_storage_cache_blue_usecase.dart';
import 'domain/usecases/wifi_usecase/save_storage_cache_wifi_usecase.dart';


final getIt = GetIt.instance;

void setup() {
  getIt
    // STORAGE
    ..registerLazySingleton<LocalStorage>(
      () => LocalStorage(),
    )
    // REPOSITORIES
    ..registerLazySingleton<IStorageRepository>(
      () => StorageRepository(
        getIt.get(),
      ),
    )

    // USE CASES
    ..registerLazySingleton<IGetStorageCacheWifiUsecase>(
      () => GetStorageCacheWifiUsecase(
        getIt.get(),
      ),
    )
    ..registerLazySingleton<ISaveStorageCacheWifiUsecase>(
      () => SaveStorageCacheWifiUsecase(
        getIt.get(),
      ),
    )
    ..registerLazySingleton<IGetStorageCacheBlueUsecase>(
          () => GetStorageCacheBlueUsecase(
        getIt.get(),
      ),
    )
    ..registerLazySingleton<ISaveStorageCacheBlueUsecase>(
          () => SaveStorageCacheBlueUsecase(
        getIt.get(),
      ),
    )

    // BLOC AND CUBIT
    ..registerLazySingleton<BluetoothPageBloc>(
          () => BluetoothPageBloc(
        getIt.get(),
        getIt.get(),
      ),
    )
    ..registerLazySingleton<WifiPageBloc>(
          () => WifiPageBloc(
        getIt.get(),
        getIt.get(),
      ),
    )
    ..registerLazySingleton<SearchCubit>(
      () => SearchCubit(),
    )
    ..registerLazySingleton<SearchBlueCubit>(
          () => SearchBlueCubit(),
    )
    ..registerLazySingleton<CameraCubit >(
          () => CameraCubit(),
    )

  ;
}
