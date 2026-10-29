import 'package:flutter/foundation.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/Settings/Domain/Entities/UserSettingsEntity.dart';
import 'package:tidyo/Features/Settings/Domain/UseCases/GetUserSettingsUseCase.dart';
import 'package:tidyo/Features/Settings/Domain/UseCases/SaveUserSettingsUseCase.dart';

class SettingsProvider extends ChangeNotifier {
  final GetUserSettingsUseCase getUserSettingsUseCase;
  final SaveUserSettingsUseCase saveUserSettingsUseCase;

  SettingsProvider({
    required this.getUserSettingsUseCase,
    required this.saveUserSettingsUseCase,
  });

  UserSettingsEntity _settings = const UserSettingsEntity();
  bool _isLoading = false;
  String? _errorMessage;

  UserSettingsEntity get settings => _settings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadSettings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getUserSettingsUseCase(const NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        _settings = data;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> toggleQuarantine(bool value) async {
    _settings = _settings.copyWith(quarantineEnabled: value);
    notifyListeners();
    await saveUserSettingsUseCase(_settings);
  }

  Future<void> toggleAutoScan(bool value) async {
    _settings = _settings.copyWith(autoScanLowStorage: value);
    notifyListeners();
    await saveUserSettingsUseCase(_settings);
  }

  Future<void> toggleNotifications(bool value) async {
    _settings = _settings.copyWith(notificationsEnabled: value);
    notifyListeners();
    await saveUserSettingsUseCase(_settings);
  }
}
