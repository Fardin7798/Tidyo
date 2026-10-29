import 'package:get_it/get_it.dart';
import 'package:tidyo/Core/Services/PermissionService.dart';
import 'package:tidyo/Core/Services/StorageService.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';
import 'package:tidyo/Features/JunkScanner/Data/DataSources/FileSystemDataSource.dart';
import 'package:tidyo/Features/JunkScanner/Data/Repositories/JunkScannerRepositoryImpl.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Repositories/IJunkScannerRepository.dart';
import 'package:tidyo/Features/JunkScanner/Domain/UseCases/ScanJunkUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Domain/UseCases/DeleteJunkUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Presentation/Providers/JunkScannerProvider.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/UseCases/GetBigFilesUseCase.dart';
import 'package:tidyo/Features/DeepClean/Domain/UseCases/ScanMediaMetricsUseCase.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ── Core Services ──────────────────────────────────────────────────────────
  if (!sl.isRegistered<PermissionService>()) {
    sl.registerLazySingleton<PermissionService>(() => PermissionService());
  }

  if (!sl.isRegistered<StorageService>()) {
    sl.registerLazySingleton<StorageService>(() => StorageService());
  }

  if (!sl.isRegistered<JunkScannerService>()) {
    sl.registerLazySingleton<JunkScannerService>(() => JunkScannerService());
  }

  // ── Data Sources ───────────────────────────────────────────────────────────
  if (!sl.isRegistered<IFileSystemDataSource>()) {
    sl.registerLazySingleton<IFileSystemDataSource>(
      () => FileSystemDataSource(sl<JunkScannerService>()),
    );
  }

  // ── Repositories ───────────────────────────────────────────────────────────
  if (!sl.isRegistered<IJunkScannerRepository>()) {
    sl.registerLazySingleton<IJunkScannerRepository>(
      () => JunkScannerRepositoryImpl(sl<IFileSystemDataSource>()),
    );
  }

  // ── Use Cases ──────────────────────────────────────────────────────────────
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

  if (!sl.isRegistered<GetBigFilesUseCase>()) {
    sl.registerLazySingleton<GetBigFilesUseCase>(
      () => GetBigFilesUseCase(sl<JunkScannerService>()),
    );
  }

  if (!sl.isRegistered<ScanMediaMetricsUseCase>()) {
    sl.registerLazySingleton<ScanMediaMetricsUseCase>(
      () => ScanMediaMetricsUseCase(),
    );
  }

  // ── Providers (ChangeNotifier) ─────────────────────────────────────────────
  if (!sl.isRegistered<JunkScannerProvider>()) {
    sl.registerFactory<JunkScannerProvider>(
      () => JunkScannerProvider(
        scanJunkUseCase: sl<ScanJunkUseCase>(),
        deleteJunkUseCase: sl<DeleteJunkUseCase>(),
      ),
    );
  }
}
