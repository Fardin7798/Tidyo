import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/Dashboard/Data/DataSources/StoragePartitionDataSource.dart';
import 'package:tidyo/Features/Dashboard/Domain/Entities/StoragePartitionEntity.dart';
import 'package:tidyo/Features/Dashboard/Domain/Repositories/IDashboardRepository.dart';

class DashboardRepositoryImpl implements IDashboardRepository {
  final IStoragePartitionDataSource dataSource;

  DashboardRepositoryImpl(this.dataSource);

  @override
  Future<Result<StoragePartitionEntity>> getStoragePartition() async {
    try {
      final partition = await dataSource.getPartition();
      return Right(partition);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
