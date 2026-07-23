import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:either_dart/either.dart';

typedef AsyncApiErrorOr<T> = Future<Either<ApiError, T>>;
