import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/Settings/Domain/Entities/UserSettingsEntity.dart';
import 'package:tidyo/Features/Settings/Domain/Repositories/ISettingsRepository.dart';

class SaveUserSettingsUseCase
    implements BaseUseCase<bool, UserSettingsEntity> {
  final ISettingsRepository repository;

  SaveUserSettingsUseCase(this.repository);

  @override
  Future<Result<bool>> call(UserSettingsEntity params) {
    return repository.saveSettings(params);
  }
}
