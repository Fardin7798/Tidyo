import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Models/JunkItemModel.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/JunkScanner/Data/DataSources/FileSystemDataSource.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Entities/JunkItemEntity.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Repositories/IJunkScannerRepository.dart';

class JunkScannerRepositoryImpl implements IJunkScannerRepository {
  final IFileSystemDataSource dataSource;

  JunkScannerRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<JunkItemEntity>>> scanJunk({
    void Function(String path, int count, int bytes)? onProgress,
  }) async {
    try {
      final models = await dataSource.scanAll(onProgress: onProgress);
      final entities = models
          .map(
            (m) => JunkItemEntity(
              path: m.path,
              name: m.name,
              sizeBytes: m.sizeBytes,
              tier: m.tier,
              categoryName: m.categoryName,
              isSelected: m.isSelected,
            ),
          )
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(ScanFailure(e.toString()));
    }
  }

  @override
  Future<Result<int>> deleteJunk(List<JunkItemEntity> items) async {
    try {
      final models = items
          .map(
            (e) => JunkItemModel(
              path: e.path,
              name: e.name,
              sizeBytes: e.sizeBytes,
              tier: e.tier,
              categoryName: e.categoryName,
              isSelected: e.isSelected,
            ),
          )
          .toList();
      final deleted = await dataSource.deleteItems(models);
      return Right(deleted);
    } catch (e) {
      return Left(DeleteFailure(e.toString()));
    }
  }

  @override
  void stopScan() {
    dataSource.stopScan();
  }
}
