import 'dart:io';
import 'package:tidyo/Features/LogsTemp/Domain/Entities/LogTempItemEntity.dart';

abstract class ILogsTempDataSource {
  Future<List<LogTempItemEntity>> getLogsTempList();
  Future<bool> deleteLogTempItem(String path);
}

class LogsTempDataSource implements ILogsTempDataSource {
  @override
  Future<List<LogTempItemEntity>> getLogsTempList() async {
    return const [
      LogTempItemEntity(
        name: 'system.log',
        dir: '/data/local/logs',
        size: '2.3 MB',
        date: 'Oct 26',
        mb: 2.3,
        previewLines: [
          '10-26 14:22:01.104 I/ActivityManager: START u0',
          '10-26 14:22:01.218 D/BatteryService: level: 84%, temp: 298',
          '10-26 14:22:02.044 W/PackageManager: package stale cache',
        ],
      ),
      LogTempItemEntity(
        name: 'crash_20241025.txt',
        dir: '/data/tombstones',
        size: '1.1 MB',
        date: 'Oct 25',
        mb: 1.1,
        previewLines: [
          '*** FATAL EXCEPTION IN SYSTEM PROCESS',
          'SIGSEGV (signal 11), code 1 (SEGV_MAPERR)',
          'pid: 1420, tid: 1455, name: Binder:1420_1',
        ],
      ),
      LogTempItemEntity(
        name: 'anr_20241024.txt',
        dir: '/data/anr',
        size: '840 KB',
        date: 'Oct 24',
        mb: 0.84,
        previewLines: [
          'ANR in com.game.heavy (main thread unresponsive for 5000ms)',
          'Load: 4.2 / 3.8 / 3.1',
        ],
      ),
      LogTempItemEntity(
        name: 'app_debug.log',
        dir: '/storage/emulated/0/Download',
        size: '620 KB',
        date: 'Oct 23',
        mb: 0.62,
        previewLines: [
          'HTTP GET /v1/sync 200 OK (312ms)',
          'Cache write complete: 48 entries',
        ],
      ),
    ];
  }

  @override
  Future<bool> deleteLogTempItem(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
