class UserSettingsEntity {
  final bool quarantineEnabled;
  final bool autoScanLowStorage;
  final bool notificationsEnabled;

  const UserSettingsEntity({
    this.quarantineEnabled = true,
    this.autoScanLowStorage = true,
    this.notificationsEnabled = false,
  });

  UserSettingsEntity copyWith({
    bool? quarantineEnabled,
    bool? autoScanLowStorage,
    bool? notificationsEnabled,
  }) {
    return UserSettingsEntity(
      quarantineEnabled: quarantineEnabled ?? this.quarantineEnabled,
      autoScanLowStorage: autoScanLowStorage ?? this.autoScanLowStorage,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
