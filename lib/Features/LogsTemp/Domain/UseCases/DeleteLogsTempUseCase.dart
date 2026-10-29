import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/LogsTemp/Domain/Repositories/ILogsTempRepository.dart';

class DeleteLogsTempParams {
  final String path;
  const DeleteLogsTempParams(this.path);
}

class DeleteLogsTempUseCase implements BaseUseCase<bool, DeleteLogsTempParams> {
  final ILogsTempRepository repository;

  DeleteLogsTempUseCase(this.repository);

  @override
  Future<Result<bool>> call(DeleteLogsTempParams params) {
    return repository.deleteLogTempItem(params.path);
  }
}
