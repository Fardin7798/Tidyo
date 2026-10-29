import 'package:tidyo/Core/Result/Result.dart';

abstract class BaseUseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams {
  const NoParams();
}
