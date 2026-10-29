import 'package:fpdart/fpdart.dart';
import 'package:tidyo/Core/Error/Failures.dart';
import 'package:tidyo/Core/Result/Result.dart';
import 'package:tidyo/Core/UseCase/BaseUseCase.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';

class GetBigFilesParams {
  final int minBytes;
  const GetBigFilesParams({this.minBytes = 50 * 1024 * 1024});
}

class GetBigFilesUseCase implements BaseUseCase<List<BigFileModel>, GetBigFilesParams> {
  final JunkScannerService scannerService;

  GetBigFilesUseCase(this.scannerService);

  @override
  Future<Result<List<BigFileModel>>> call(GetBigFilesParams params) async {
    try {
      final files = await scannerService.findBigFiles(minBytes: params.minBytes);
      return Right(files);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
