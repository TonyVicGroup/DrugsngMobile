import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/features/consultation/data/datasource/consultation_datasource.dart';
import 'package:drugs_ng/features/consultation/data/models/consult_service.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_home_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_parameters.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:either_dart/either.dart';

class ConsultationRepository {
  final ConsultationDatasource datasource = ConsultationDatasource();

  AsyncApiErrorOr<void> addConsultation(ConsultationData data) async {
    try {
      final response = await datasource.addConsultation(data);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<ConsultationDetails>> getConsultations(
    ConsultationParameters parameters,
  ) async {
    try {
      final response = await datasource.getConsultations(parameters);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<ConsultationHomeData> getHomeData() async {
    try {
      final result = await datasource.getHomeData();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
