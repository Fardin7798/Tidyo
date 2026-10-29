import 'package:fpdart/fpdart.dart';
import '../error/Failures.dart';

typedef Result<T> = Either<Failure, T>;
