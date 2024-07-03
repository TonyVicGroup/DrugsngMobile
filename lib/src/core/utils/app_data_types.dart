import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:either_dart/either.dart';

typedef AsyncErrorOr<T> = Future<Either<AppError, T>>;
