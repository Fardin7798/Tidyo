import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/AppCache/Data/DataSources/AppCacheDataSource.dart';
import 'package:tidyo/Features/AppCache/Domain/Entities/AppCacheEntity.dart';
import 'package:tidyo/Features/AppCache/Domain/Repositories/IAppCacheRepository.dart';

class AppCacheRepositoryImpl implements IAppCacheRepository {
  final IAppCacheDataSource dataSource;

  AppCacheRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<AppCacheEntity>>> getAppCacheList() async {
    try {
      final list = await dataSource.getAppCacheList();
      return Right(list);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> launchAppDetails(String packageName) async {
    try {
      final success = await dataSource.launchAppDetails(packageName);
      return Right(success);
    } catch (e) {
      return Left(PlatformFailure(e.toString()));
    }
  }
}
