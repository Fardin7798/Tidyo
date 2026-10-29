import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../constants/AppConstants.dart';

class StorageService {
  Future<String> getRootStoragePath() async {
    if (Platform.isAndroid) {
      final extDir = await getExternalStorageDirectory();
      if (extDir != null) {
        final path = extDir.path;
        final androidIndex = path.indexOf('/Android/');
        if (androidIndex != -1) {
          return path.substring(0, androidIndex);
        }
      }
      final defaultDir = Directory(AppConstants.defaultStoragePath);
      if (await defaultDir.exists()) {
        return AppConstants.defaultStoragePath;
      }
    }
    final docDir = await getApplicationDocumentsDirectory();
    return docDir.path;
  }

  Future<Map<String, int>> getStorageMetrics() async {
    final rootPath = await getRootStoragePath();
    final rootDir = Directory(rootPath);
    
    int usedBytes = 0;
    if (await rootDir.exists()) {
      try {
        final stat = await rootDir.stat();
        usedBytes = stat.size;
      } catch (_) {
        usedBytes = 0;
      }
    }

    // Default estimates or partition metrics
    const int estimatedTotal = 64 * 1024 * 1024 * 1024; // 64 GB baseline
    final int estimatedFree = estimatedTotal > usedBytes ? estimatedTotal - usedBytes : 0;

    return {
      'totalBytes': estimatedTotal,
      'usedBytes': usedBytes,
      'freeBytes': estimatedFree,
    };
  }
}
