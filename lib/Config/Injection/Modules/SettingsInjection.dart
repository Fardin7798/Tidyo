import 'package:get_it/get_it.dart';
import 'package:tidyo/Features/Settings/Data/DataSources/SettingsLocalDataSource.dart';
import 'package:tidyo/Features/Settings/Data/Repositories/SettingsRepositoryImpl.dart';
import 'package:tidyo/Features/Settings/Domain/Repositories/ISettingsRepository.dart';
import 'package:tidyo/Features/Settings/Domain/UseCases/GetUserSettingsUseCase.dart';
import 'package:tidyo/Features/Settings/Domain/UseCases/SaveUserSettingsUseCase.dart';
import 'package:tidyo/Features/Settings/Presentation/Providers/SettingsProvider.dart';

void initSettingsInjection(GetIt sl) {
  if (!sl.isRegistered<ISettingsLocalDataSource>()) {
    sl.registerLazySingleton<ISettingsLocalDataSource>(
      () => SettingsLocalDataSource(),
    );
  }

  if (!sl.isRegistered<ISettingsRepository>()) {
    sl.registerLazySingleton<ISettingsRepository>(
      () => SettingsRepositoryImpl(sl<ISettingsLocalDataSource>()),
    );
  }

  if (!sl.isRegistered<GetUserSettingsUseCase>()) {
    sl.registerLazySingleton<GetUserSettingsUseCase>(
      () => GetUserSettingsUseCase(sl<ISettingsRepository>()),
    );
  }

  if (!sl.isRegistered<SaveUserSettingsUseCase>()) {
    sl.registerLazySingleton<SaveUserSettingsUseCase>(
      () => SaveUserSettingsUseCase(sl<ISettingsRepository>()),
    );
  }

  if (!sl.isRegistered<SettingsProvider>()) {
    sl.registerFactory<SettingsProvider>(
      () => SettingsProvider(
        getUserSettingsUseCase: sl<GetUserSettingsUseCase>(),
        saveUserSettingsUseCase: sl<SaveUserSettingsUseCase>(),
      ),
    );
  }
}
