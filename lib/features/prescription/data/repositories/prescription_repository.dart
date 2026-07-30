import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/prescription/data/datasources/prescription_datasource.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';

class PrescriptionRepository {
  final PrescriptionDatasource datasource = PrescriptionDatasource();

  AsyncApiErrorOr<Prescription> addData(int userId, PlatformFile file) async {
    try {
      final result = await datasource.addData(userId, file);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> delete(int productId) async {
    try {
      final result = await datasource.delete(productId);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<Prescription>> getData(
    int userId, [
    int pageNumber = 1,
    int pageSize = 15,
  ]) async {
    try {
      final result = await datasource.getData(userId, pageNumber, pageSize);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
