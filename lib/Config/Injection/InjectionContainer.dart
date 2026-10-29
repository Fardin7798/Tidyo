import 'package:get_it/get_it.dart';
import 'package:tidyo/Config/Injection/Modules/CoreInjection.dart';
import 'package:tidyo/Config/Injection/Modules/DashboardInjection.dart';
import 'package:tidyo/Config/Injection/Modules/JunkScannerInjection.dart';
import 'package:tidyo/Config/Injection/Modules/StorageAnalyzerInjection.dart';
import 'package:tidyo/Config/Injection/Modules/DeepCleanInjection.dart';
import 'package:tidyo/Config/Injection/Modules/AppCacheInjection.dart';
import 'package:tidyo/Config/Injection/Modules/ResidualFilesInjection.dart';
import 'package:tidyo/Config/Injection/Modules/LogsTempInjection.dart';
import 'package:tidyo/Config/Injection/Modules/SettingsInjection.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  initCoreInjection(sl);
  initDashboardInjection(sl);
  initJunkScannerInjection(sl);
  initStorageAnalyzerInjection(sl);
  initDeepCleanInjection(sl);
  initAppCacheInjection(sl);
  initResidualFilesInjection(sl);
  initLogsTempInjection(sl);
  initSettingsInjection(sl);
}
