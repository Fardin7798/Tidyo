import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/DeepClean/Data/DataSources/DeepCleanDataSource.dart';
import 'package:tidyo/Features/DeepClean/Domain/Entities/MediaMetricsEntity.dart';
import 'package:tidyo/Features/DeepClean/Domain/Repositories/IDeepCleanRepository.dart';

class DeepCleanRepositoryImpl implements IDeepCleanRepository {
  final IDeepCleanDataSource dataSource;

  DeepCleanRepositoryImpl(this.dataSource);

  @override
  Future<Result<MediaMetricsEntity>> getMediaMetrics() async {
    try {
      final metrics = await dataSource.getMediaMetrics();
      return Right(metrics);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
