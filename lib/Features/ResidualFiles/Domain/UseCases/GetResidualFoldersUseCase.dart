import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Entities/ResidualFolderEntity.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Repositories/IResidualFilesRepository.dart';

class GetResidualFoldersUseCase
    implements BaseUseCase<List<ResidualFolderEntity>, NoParams> {
  final IResidualFilesRepository repository;

  GetResidualFoldersUseCase(this.repository);

  @override
  Future<Result<List<ResidualFolderEntity>>> call(NoParams params) {
    return repository.getResidualFolders();
  }
}
