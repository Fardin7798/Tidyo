import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Entities/BigFileEntity.dart';

abstract class IStorageAnalyzerRepository {
  Future<Result<List<BigFileEntity>>> getBigFiles({int minBytes = 50 * 1024 * 1024});
}
