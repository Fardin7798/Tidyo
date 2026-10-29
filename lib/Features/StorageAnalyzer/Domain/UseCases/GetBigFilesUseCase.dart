import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Entities/BigFileEntity.dart';
import 'package:tidyo/Features/StorageAnalyzer/Domain/Repositories/IStorageAnalyzerRepository.dart';

class GetBigFilesParams {
  final int minBytes;
  const GetBigFilesParams({this.minBytes = 50 * 1024 * 1024});
}

class GetBigFilesUseCase implements BaseUseCase<List<BigFileEntity>, GetBigFilesParams> {
  final IStorageAnalyzerRepository repository;

  GetBigFilesUseCase(this.repository);

  @override
  Future<Result<List<BigFileEntity>>> call(GetBigFilesParams params) {
    return repository.getBigFiles(minBytes: params.minBytes);
  }
}
