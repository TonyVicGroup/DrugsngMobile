import 'package:dio/dio.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';

class PrescriptionDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<Prescription> addData(int userId, PlatformFile file) async {
    final formData = FormData.fromMap({
      'UserId': userId,
      'type': lookupMimeType(file.path!),
      'File': MultipartFile.fromFileSync(file.path!, filename: file.name),
    });

    final response = await service.postFormData(
      path: 'prescription',
      data: formData,
    );

    if (response.hasError) throw response.error;
    return Prescription.fromJson(response.data!['data']);
  }

  Future<void> delete(int productId) async {
    final response = await service.delete(path: 'prescription/$productId');
    if (response.hasError) throw response.error;
    return;
  }

  Future<List<Prescription>> getData(
    int userId, [
    int pageNumber = 1,
    int pageSize = 15,
  ]) async {
    final response = await service.get(
      path: 'prescription/user/$userId',
      params: {'PageNumber': pageNumber, 'PageSize': pageSize},
    );
    if (response.hasError) throw response.error;
    return List<Map>.from(
      response.data!['data'],
    ).map((prod) => Prescription.fromJson(prod)).toList();
  }
}
