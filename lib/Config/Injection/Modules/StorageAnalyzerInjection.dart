import 'package:get_it/get_it.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';
import 'package:tidyo/Features/StorageAnalyzer/Data/DataSources/StorageAnalyzerDataSource.dart';
import 'package:tidyo/Features/StorageAnalyzer/Data/Repositories/StorageAnalyzerRepositoryImpl.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Repositories/IStorageAnalyzerRepository.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/UseCases/GetBigFilesUseCase.dart';
import 'package:tidyo/Features/StorageAnalyzer/Presentation/Providers/StorageAnalyzerProvider.dart';

void initStorageAnalyzerInjection(GetIt sl) {
  if (!sl.isRegistered<IStorageAnalyzerDataSource>()) {
    sl.registerLazySingleton<IStorageAnalyzerDataSource>(
      () => StorageAnalyzerDataSource(sl<JunkScannerService>()),
    );
  }

  if (!sl.isRegistered<IStorageAnalyzerRepository>()) {
    sl.registerLazySingleton<IStorageAnalyzerRepository>(
      () => StorageAnalyzerRepositoryImpl(sl<IStorageAnalyzerDataSource>()),
    );
  }

  if (!sl.isRegistered<GetBigFilesUseCase>()) {
    sl.registerLazySingleton<GetBigFilesUseCase>(
      () => GetBigFilesUseCase(sl<IStorageAnalyzerRepository>()),
    );
  }

  if (!sl.isRegistered<StorageAnalyzerProvider>()) {
    sl.registerFactory<StorageAnalyzerProvider>(
      () => StorageAnalyzerProvider(
        getBigFilesUseCase: sl<GetBigFilesUseCase>(),
      ),
    );
  }
}
