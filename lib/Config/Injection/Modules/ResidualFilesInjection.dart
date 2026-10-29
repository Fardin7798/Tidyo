import 'package:get_it/get_it.dart';
import 'package:tidyo/Features/ResidualFiles/Data/DataSources/ResidualFilesDataSource.dart';
import 'package:tidyo/Features/ResidualFiles/Data/Repositories/ResidualFilesRepositoryImpl.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Repositories/IResidualFilesRepository.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/UseCases/GetResidualFoldersUseCase.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/UseCases/DeleteResidualFolderUseCase.dart';
import 'package:tidyo/Features/ResidualFiles/Presentation/Providers/ResidualFilesProvider.dart';

void initResidualFilesInjection(GetIt sl) {
  if (!sl.isRegistered<IResidualFilesDataSource>()) {
    sl.registerLazySingleton<IResidualFilesDataSource>(
      () => ResidualFilesDataSource(),
    );
  }

  if (!sl.isRegistered<IResidualFilesRepository>()) {
    sl.registerLazySingleton<IResidualFilesRepository>(
      () => ResidualFilesRepositoryImpl(sl<IResidualFilesDataSource>()),
    );
  }

  if (!sl.isRegistered<GetResidualFoldersUseCase>()) {
    sl.registerLazySingleton<GetResidualFoldersUseCase>(
      () => GetResidualFoldersUseCase(sl<IResidualFilesRepository>()),
    );
  }

  if (!sl.isRegistered<DeleteResidualFolderUseCase>()) {
    sl.registerLazySingleton<DeleteResidualFolderUseCase>(
      () => DeleteResidualFolderUseCase(sl<IResidualFilesRepository>()),
    );
  }

  if (!sl.isRegistered<ResidualFilesProvider>()) {
    sl.registerFactory<ResidualFilesProvider>(
      () => ResidualFilesProvider(
        getResidualFoldersUseCase: sl<GetResidualFoldersUseCase>(),
        deleteResidualFolderUseCase: sl<DeleteResidualFolderUseCase>(),
      ),
    );
  }
}
