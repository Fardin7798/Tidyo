import 'package:tidyo/Core/Services/JunkScannerService.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Entities/BigFileEntity.dart';

abstract class IStorageAnalyzerDataSource {
  Future<List<BigFileEntity>> getBigFiles({required int minBytes});
}

class StorageAnalyzerDataSource implements IStorageAnalyzerDataSource {
  final JunkScannerService scannerService;

  StorageAnalyzerDataSource(this.scannerService);

  @override
  Future<List<BigFileEntity>> getBigFiles({required int minBytes}) async {
    final models = await scannerService.findBigFiles(minBytes: minBytes);
    return models
        .map(
          (m) => BigFileEntity(
            name: m.name,
            path: m.path,
            sizeBytes: m.sizeBytes,
          ),
        )
        .toList();
  }
}
