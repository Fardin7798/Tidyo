import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/AppCache/Domain/Repositories/IAppCacheRepository.dart';

class LaunchAppDetailsParams {
  final String packageName;
  const LaunchAppDetailsParams(this.packageName);
}

class LaunchAppDetailsUseCase implements BaseUseCase<bool, LaunchAppDetailsParams> {
  final IAppCacheRepository repository;

  LaunchAppDetailsUseCase(this.repository);

  @override
  Future<Result<bool>> call(LaunchAppDetailsParams params) {
    return repository.launchAppDetails(params.packageName);
  }
}
