import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/ResidualFiles/Data/DataSources/ResidualFilesDataSource.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Entities/ResidualFolderEntity.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Repositories/IResidualFilesRepository.dart';

class ResidualFilesRepositoryImpl implements IResidualFilesRepository {
  final IResidualFilesDataSource dataSource;

  ResidualFilesRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<ResidualFolderEntity>>> getResidualFolders() async {
    try {
      final folders = await dataSource.getResidualFolders();
      return Right(folders);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> deleteResidualFolder(String path) async {
    try {
      final success = await dataSource.deleteResidualFolder(path);
      return Right(success);
    } catch (e) {
      return Left(DeleteFailure(e.toString()));
    }
  }
}
