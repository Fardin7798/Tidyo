import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/LogsTemp/Data/DataSources/LogsTempDataSource.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Entities/LogTempItemEntity.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Repositories/ILogsTempRepository.dart';

class LogsTempRepositoryImpl implements ILogsTempRepository {
  final ILogsTempDataSource dataSource;

  LogsTempRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<LogTempItemEntity>>> getLogsTempList() async {
    try {
      final list = await dataSource.getLogsTempList();
      return Right(list);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> deleteLogTempItem(String path) async {
    try {
      final success = await dataSource.deleteLogTempItem(path);
      return Right(success);
    } catch (e) {
      return Left(DeleteFailure(e.toString()));
    }
  }
}
