import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Entities/LogTempItemEntity.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Repositories/ILogsTempRepository.dart';

class GetLogsTempListUseCase
    implements BaseUseCase<List<LogTempItemEntity>, NoParams> {
  final ILogsTempRepository repository;

  GetLogsTempListUseCase(this.repository);

  @override
  Future<Result<List<LogTempItemEntity>>> call(NoParams params) {
    return repository.getLogsTempList();
  }
}
