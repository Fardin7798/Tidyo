import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/Settings/Data/DataSources/SettingsLocalDataSource.dart';
import 'package:tidyo/Features/Settings/Domain/Entities/UserSettingsEntity.dart';
import 'package:tidyo/Features/Settings/Domain/Repositories/ISettingsRepository.dart';

class SettingsRepositoryImpl implements ISettingsRepository {
  final ISettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<Result<UserSettingsEntity>> getSettings() async {
    try {
      final settings = await dataSource.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> saveSettings(UserSettingsEntity settings) async {
    try {
      final success = await dataSource.saveSettings(settings);
      return Right(success);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
