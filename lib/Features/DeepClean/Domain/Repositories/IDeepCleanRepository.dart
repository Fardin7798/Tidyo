import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/DeepClean/Domain/Entities/MediaMetricsEntity.dart';

abstract class IDeepCleanRepository {
  Future<Result<MediaMetricsEntity>> getMediaMetrics();
}
