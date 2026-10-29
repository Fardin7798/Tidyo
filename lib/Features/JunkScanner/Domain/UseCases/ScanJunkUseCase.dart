import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Entities/JunkItemEntity.dart';
import 'package:tidyo/Features/JunkScanner/Domain/Repositories/IJunkScannerRepository.dart';

class ScanJunkParams {
  final void Function(String path, int count, int bytes)? onProgress;
  const ScanJunkParams({this.onProgress});
}

class ScanJunkUseCase implements BaseUseCase<List<JunkItemEntity>, ScanJunkParams> {
  final IJunkScannerRepository repository;

  ScanJunkUseCase(this.repository);

  @override
  Future<Result<List<JunkItemEntity>>> call(ScanJunkParams params) {
    return repository.scanJunk(onProgress: params.onProgress);
  }

  void stop() {
    repository.stopScan();
  }
}
