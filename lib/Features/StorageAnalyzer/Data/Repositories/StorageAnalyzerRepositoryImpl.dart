import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/StorageAnalyzer/Data/DataSources/StorageAnalyzerDataSource.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Entities/BigFileEntity.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Repositories/IStorageAnalyzerRepository.dart';

class StorageAnalyzerRepositoryImpl implements IStorageAnalyzerRepository {
  final IStorageAnalyzerDataSource dataSource;

  StorageAnalyzerRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<BigFileEntity>>> getBigFiles({int minBytes = 50 * 1024 * 1024}) async {
    try {
      final items = await dataSource.getBigFiles(minBytes: minBytes);
      return Right(items);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
