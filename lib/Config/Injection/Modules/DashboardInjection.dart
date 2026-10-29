import 'package:get_it/get_it.dart';
import 'package:tidyo/Features/Dashboard/Data/DataSources/StoragePartitionDataSource.dart';
import 'package:tidyo/Features/Dashboard/Data/Repositories/DashboardRepositoryImpl.dart';
import 'package:tidyo/Features/Dashboard/Domain/Repositories/IDashboardRepository.dart';
import 'package:tidyo/Features/Dashboard/Domain/UseCases/GetStoragePartitionUseCase.dart';
import 'package:tidyo/Features/Dashboard/Presentation/Providers/DashboardProvider.dart';

void initDashboardInjection(GetIt sl) {
  if (!sl.isRegistered<IStoragePartitionDataSource>()) {
    sl.registerLazySingleton<IStoragePartitionDataSource>(
      () => StoragePartitionDataSource(),
    );
  }

  if (!sl.isRegistered<IDashboardRepository>()) {
    sl.registerLazySingleton<IDashboardRepository>(
      () => DashboardRepositoryImpl(sl<IStoragePartitionDataSource>()),
    );
  }

  if (!sl.isRegistered<GetStoragePartitionUseCase>()) {
    sl.registerLazySingleton<GetStoragePartitionUseCase>(
      () => GetStoragePartitionUseCase(sl<IDashboardRepository>()),
    );
  }

  if (!sl.isRegistered<DashboardProvider>()) {
    sl.registerFactory<DashboardProvider>(
      () => DashboardProvider(
        getStoragePartitionUseCase: sl<GetStoragePartitionUseCase>(),
      ),
    );
  }
}
