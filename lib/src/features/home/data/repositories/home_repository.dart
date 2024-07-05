import 'package:drugs_ng/src/core/data/models/app_error.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/home/data/models/home_data.dart';
import 'package:drugs_ng/src/features/home/domain/repositories/home_datasource.dart';
import 'package:either_dart/either.dart';

class HomeRepository {
  final HomeDatasource datasource;

  HomeRepository(this.datasource);

  AsyncErrorOr<HomeData> getData() async {
    // try {
    HomeData data = await datasource.getData();
    return Right(data);
    // } catch (e) {
    //   return Left(AppError(e.toString()));
    // }
  }
}
