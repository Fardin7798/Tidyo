import 'package:tidyo/Features/DeepClean/Domain/Entities/MediaMetricsEntity.dart';
import 'package:tidyo/Features/DeepClean/Domain/Repositories/IDeepCleanRepository.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';


class ScanMediaMetricsUseCase implements BaseUseCase<MediaMetricsEntity, NoParams> {
  final IDeepCleanRepository repository;

  ScanMediaMetricsUseCase(this.repository);
  @override
  Future<Result<MediaMetricsEntity>> call(NoParams params) => repository.getMediaMetrics();
}
