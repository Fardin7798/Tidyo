import 'package:tidyo/Core/Models/JunkItemModel.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';

abstract class IFileSystemDataSource {
  Future<List<JunkItemModel>> scanAll({
    void Function(String path, int count, int bytes)? onProgress,
  });

  Future<int> deleteItems(List<JunkItemModel> items);

  void stopScan();
}

class FileSystemDataSource implements IFileSystemDataSource {
  final JunkScannerService scannerService;

  FileSystemDataSource(this.scannerService);

  @override
  Future<List<JunkItemModel>> scanAll({
    void Function(String path, int count, int bytes)? onProgress,
  }) {
    return scannerService.scanAll(onProgress: onProgress);
  }

  @override
  Future<int> deleteItems(List<JunkItemModel> items) {
    return scannerService.deleteItems(items);
  }

  @override
  void stopScan() {
    scannerService.stopScan();
  }
}
