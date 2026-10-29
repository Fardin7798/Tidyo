import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/Settings/Domain/Entities/UserSettingsEntity.dart';

abstract class ISettingsRepository {
  Future<Result<UserSettingsEntity>> getSettings();
  Future<Result<bool>> saveSettings(UserSettingsEntity settings);
}
