import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Entities/JunkItemEntity.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Repositories/IJunkScannerRepository.dart';

class DeleteJunkUseCase implements BaseUseCase<int, List<JunkItemEntity>> {
  final IJunkScannerRepository repository;

  DeleteJunkUseCase(this.repository);

  @override
  Future<Result<int>> call(List<JunkItemEntity> params) {
    return repository.deleteJunk(params);
  }
}
