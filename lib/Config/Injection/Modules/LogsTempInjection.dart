import 'package:get_it/get_it.dart';
import 'package:tidyo/Features/LogsTemp/Data/DataSources/LogsTempDataSource.dart';
import 'package:tidyo/Features/LogsTemp/Data/Repositories/LogsTempRepositoryImpl.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Repositories/ILogsTempRepository.dart';
import 'package:tidyo/Features/LogsTemp/Domain/UseCases/GetLogsTempListUseCase.dart';
import 'package:tidyo/Features/LogsTemp/Domain/UseCases/DeleteLogsTempUseCase.dart';
import 'package:tidyo/Features/LogsTemp/Presentation/Providers/LogsTempProvider.dart';

void initLogsTempInjection(GetIt sl) {
  if (!sl.isRegistered<ILogsTempDataSource>()) {
    sl.registerLazySingleton<ILogsTempDataSource>(
      () => LogsTempDataSource(),
    );
  }

  if (!sl.isRegistered<ILogsTempRepository>()) {
    sl.registerLazySingleton<ILogsTempRepository>(
      () => LogsTempRepositoryImpl(sl<ILogsTempDataSource>()),
    );
  }

  if (!sl.isRegistered<GetLogsTempListUseCase>()) {
    sl.registerLazySingleton<GetLogsTempListUseCase>(
      () => GetLogsTempListUseCase(sl<ILogsTempRepository>()),
    );
  }

  if (!sl.isRegistered<DeleteLogsTempUseCase>()) {
    sl.registerLazySingleton<DeleteLogsTempUseCase>(
      () => DeleteLogsTempUseCase(sl<ILogsTempRepository>()),
    );
  }

  if (!sl.isRegistered<LogsTempProvider>()) {
    sl.registerFactory<LogsTempProvider>(
      () => LogsTempProvider(
        getLogsTempListUseCase: sl<GetLogsTempListUseCase>(),
        deleteLogsTempUseCase: sl<DeleteLogsTempUseCase>(),
      ),
    );
  }
}
