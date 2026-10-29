import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/AppCache/Domain/Entities/AppCacheEntity.dart';

abstract class IAppCacheRepository {
  Future<Result<List<AppCacheEntity>>> getAppCacheList();
  Future<Result<bool>> launchAppDetails(String packageName);
}
