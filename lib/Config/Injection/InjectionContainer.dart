import 'package:get_it/get_it.dart';
import 'package:tidyo/Core/Services/PermissionService.dart';
import 'package:tidyo/Core/Services/StorageService.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  if (!sl.isRegistered<PermissionService>()) {
    sl.registerLazySingleton<PermissionService>(() => PermissionService());
  }

  if (!sl.isRegistered<StorageService>()) {
    sl.registerLazySingleton<StorageService>(() => StorageService());
  }

  if (!sl.isRegistered<JunkScannerService>()) {
    sl.registerLazySingleton<JunkScannerService>(() => JunkScannerService());
  }
}
