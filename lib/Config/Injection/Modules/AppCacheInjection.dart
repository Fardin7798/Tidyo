import 'package:get_it/get_it.dart';
import 'package:tidyo/Features/AppCache/Data/DataSources/AppCacheDataSource.dart';
import 'package:tidyo/Features/AppCache/Data/Repositories/AppCacheRepositoryImpl.dart';
import 'package:tidyo/Features/AppCache/Domain/Repositories/IAppCacheRepository.dart';
import 'package:tidyo/Features/AppCache/Domain/UseCases/GetAppCacheListUseCase.dart';
import 'package:tidyo/Features/AppCache/Domain/UseCases/LaunchAppDetailsUseCase.dart';
import 'package:tidyo/Features/AppCache/Presentation/Providers/AppCacheProvider.dart';

void initAppCacheInjection(GetIt sl) {
  if (!sl.isRegistered<IAppCacheDataSource>()) {
    sl.registerLazySingleton<IAppCacheDataSource>(
      () => AppCacheDataSource(),
    );
  }

  if (!sl.isRegistered<IAppCacheRepository>()) {
    sl.registerLazySingleton<IAppCacheRepository>(
      () => AppCacheRepositoryImpl(sl<IAppCacheDataSource>()),
    );
  }

  if (!sl.isRegistered<GetAppCacheListUseCase>()) {
    sl.registerLazySingleton<GetAppCacheListUseCase>(
      () => GetAppCacheListUseCase(sl<IAppCacheRepository>()),
    );
  }

  if (!sl.isRegistered<LaunchAppDetailsUseCase>()) {
    sl.registerLazySingleton<LaunchAppDetailsUseCase>(
      () => LaunchAppDetailsUseCase(sl<IAppCacheRepository>()),
    );
  }

  if (!sl.isRegistered<AppCacheProvider>()) {
    sl.registerFactory<AppCacheProvider>(
      () => AppCacheProvider(
        getAppCacheListUseCase: sl<GetAppCacheListUseCase>(),
        launchAppDetailsUseCase: sl<LaunchAppDetailsUseCase>(),
      ),
    );
  }
}
