import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/AppCache/Domain/Entities/AppCacheEntity.dart';
import 'package:tidyo/Features/AppCache/Domain/Repositories/IAppCacheRepository.dart';

class GetAppCacheListUseCase implements BaseUseCase<List<AppCacheEntity>, NoParams> {
  final IAppCacheRepository repository;

  GetAppCacheListUseCase(this.repository);

  @override
  Future<Result<List<AppCacheEntity>>> call(NoParams params) {
    return repository.getAppCacheList();
  }
}
