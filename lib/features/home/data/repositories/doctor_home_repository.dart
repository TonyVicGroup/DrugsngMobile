import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/home/data/datasource/doctor_home_datasource.dart';
import 'package:drugs_ng/features/home/data/models/doctor_dashboard.dart';
import 'package:either_dart/either.dart';

class DoctorHomeRepository {
  final _repo = DoctorHomeDatasource();

  AsyncApiErrorOr<DoctorDashboard> getDashboard(int userId) async {
    try {
      final response = await _repo.getDashboard(userId);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
