import 'package:tidyo/Features/Settings/Domain/Entities/UserSettingsEntity.dart';

abstract class ISettingsLocalDataSource {
  Future<UserSettingsEntity> getSettings();
  Future<bool> saveSettings(UserSettingsEntity settings);
}

class SettingsLocalDataSource implements ISettingsLocalDataSource {
  UserSettingsEntity _cachedSettings = const UserSettingsEntity();

  @override
  Future<UserSettingsEntity> getSettings() async {
    return _cachedSettings;
  }

  @override
  Future<bool> saveSettings(UserSettingsEntity settings) async {
    _cachedSettings = settings;
    return true;
  }
}
