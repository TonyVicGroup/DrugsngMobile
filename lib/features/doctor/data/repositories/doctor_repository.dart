import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_parameters.dart';
import 'package:drugs_ng/features/doctor/data/datasources/doctor_datasource.dart';
import 'package:either_dart/either.dart';

class DoctorRepository {
  DoctorDatasource datasource = DoctorDatasource();

  AsyncApiErrorOr<DoctorDetails> getDoctor(int id) async {
    try {
      final response = await datasource.getDoctor(id);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<Doctor>> getDoctors(DoctorParameters parameters) async {
    try {
      final response = await datasource.getDoctors(parameters);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
