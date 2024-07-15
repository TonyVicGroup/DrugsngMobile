import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:either_dart/either.dart';

typedef AsyncApiErrorOr<T> = Future<Either<ApiError, T>>;
