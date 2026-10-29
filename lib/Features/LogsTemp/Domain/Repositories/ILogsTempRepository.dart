import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Entities/LogTempItemEntity.dart';

abstract class ILogsTempRepository {
  Future<Result<List<LogTempItemEntity>>> getLogsTempList();
  Future<Result<bool>> deleteLogTempItem(String path);
}
