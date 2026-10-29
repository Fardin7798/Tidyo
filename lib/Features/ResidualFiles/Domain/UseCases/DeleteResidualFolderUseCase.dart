import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Repositories/IResidualFilesRepository.dart';

class DeleteResidualFolderParams {
  final String path;
  const DeleteResidualFolderParams(this.path);
}

class DeleteResidualFolderUseCase
    implements BaseUseCase<bool, DeleteResidualFolderParams> {
  final IResidualFilesRepository repository;

  DeleteResidualFolderUseCase(this.repository);

  @override
  Future<Result<bool>> call(DeleteResidualFolderParams params) {
    return repository.deleteResidualFolder(params.path);
  }
}
