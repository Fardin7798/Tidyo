import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Features/Dashboard/Domain/Entities/StoragePartitionEntity.dart';
import 'package:tidyo/Features/Dashboard/Domain/Repositories/IDashboardRepository.dart';

class GetStoragePartitionUseCase
    implements BaseUseCase<StoragePartitionEntity, NoParams> {
  final IDashboardRepository repository;

  GetStoragePartitionUseCase(this.repository);

  @override
  Future<Result<StoragePartitionEntity>> call(NoParams params) {
    return repository.getStoragePartition();
  }
}
