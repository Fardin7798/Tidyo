import 'package:get_it/get_it.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';
import 'package:tidyo/Features/JunkScanner/Data/DataSources/FileSystemDataSource.dart';
import 'package:tidyo/Features/JunkScanner/Data/Repositories/JunkScannerRepositoryImpl.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Repositories/IJunkScannerRepository.dart';
import 'package:tidyo/Features/JunkScanner/Domain/UseCases/ScanJunkUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Domain/UseCases/DeleteJunkUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Presentation/Providers/JunkScannerProvider.dart';

void initJunkScannerInjection(GetIt sl) {
  if (!sl.isRegistered<IFileSystemDataSource>()) {
    sl.registerLazySingleton<IFileSystemDataSource>(
      () => FileSystemDataSource(sl<JunkScannerService>()),
    );
  }

  if (!sl.isRegistered<IJunkScannerRepository>()) {
    sl.registerLazySingleton<IJunkScannerRepository>(
      () => JunkScannerRepositoryImpl(sl<IFileSystemDataSource>()),
    );
  }

  if (!sl.isRegistered<ScanJunkUseCase>()) {
    sl.registerLazySingleton<ScanJunkUseCase>(
      () => ScanJunkUseCase(sl<IJunkScannerRepository>()),
    );
  }

  if (!sl.isRegistered<DeleteJunkUseCase>()) {
    sl.registerLazySingleton<DeleteJunkUseCase>(
      () => DeleteJunkUseCase(sl<IJunkScannerRepository>()),
    );
  }

  if (!sl.isRegistered<JunkScannerProvider>()) {
    sl.registerFactory<JunkScannerProvider>(
      () => JunkScannerProvider(
        scanJunkUseCase: sl<ScanJunkUseCase>(),
        deleteJunkUseCase: sl<DeleteJunkUseCase>(),
      ),
    );
  }
}
