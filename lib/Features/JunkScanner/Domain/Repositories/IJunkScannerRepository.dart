import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Entities/JunkItemEntity.dart';

abstract class IJunkScannerRepository {
  Future<Result<List<JunkItemEntity>>> scanJunk({
    void Function(String path, int count, int bytes)? onProgress,
  });

  Future<Result<int>> deleteJunk(List<JunkItemEntity> items);

  void stopScan();
}
