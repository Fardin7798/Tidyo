import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/Dashboard/Domain/Entities/StoragePartitionEntity.dart';

abstract class IDashboardRepository {
  Future<Result<StoragePartitionEntity>> getStoragePartition();
}
