import 'package:get_it/get_it.dart';
import 'package:tidyo/Features/DeepClean/Data/DataSources/DeepCleanDataSource.dart';
import 'package:tidyo/Features/DeepClean/Data/Repositories/DeepCleanRepositoryImpl.dart';
import 'package:tidyo/Features/DeepClean/Domain/Repositories/IDeepCleanRepository.dart';
import 'package:tidyo/Features/DeepClean/Domain/UseCases/ScanMediaMetricsUseCase.dart';
import 'package:tidyo/Features/DeepClean/Presentation/Providers/DeepCleanProvider.dart';

void initDeepCleanInjection(GetIt sl) {
  if (!sl.isRegistered<IDeepCleanDataSource>()) {
    sl.registerLazySingleton<IDeepCleanDataSource>(
      () => DeepCleanDataSource(),
    );
  }

  if (!sl.isRegistered<IDeepCleanRepository>()) {
    sl.registerLazySingleton<IDeepCleanRepository>(
      () => DeepCleanRepositoryImpl(sl<IDeepCleanDataSource>()),
    );
  }

  if (!sl.isRegistered<ScanMediaMetricsUseCase>()) {
    sl.registerLazySingleton<ScanMediaMetricsUseCase>(
      () => ScanMediaMetricsUseCase(sl<IDeepCleanRepository>()),
    );
  }

  if (!sl.isRegistered<DeepCleanProvider>()) {
    sl.registerFactory<DeepCleanProvider>(
      () => DeepCleanProvider(
        scanMediaMetricsUseCase: sl<ScanMediaMetricsUseCase>(),
      ),
    );
  }
}
