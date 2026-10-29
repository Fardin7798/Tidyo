import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Features/ResidualFiles/Domain/Entities/ResidualFolderEntity.dart';

abstract class IResidualFilesRepository {
  Future<Result<List<ResidualFolderEntity>>> getResidualFolders();
  Future<Result<bool>> deleteResidualFolder(String path);
}
