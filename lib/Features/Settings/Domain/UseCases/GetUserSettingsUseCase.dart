import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/Settings/Domain/Entities/UserSettingsEntity.dart';
import 'package:tidyo/Features/Settings/Domain/Repositories/ISettingsRepository.dart';

class GetUserSettingsUseCase implements BaseUseCase<UserSettingsEntity, NoParams> {
  final ISettingsRepository repository;

  GetUserSettingsUseCase(this.repository);

  @override
  Future<Result<UserSettingsEntity>> call(NoParams params) {
    return repository.getSettings();
  }
}
