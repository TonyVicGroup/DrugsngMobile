import 'package:dio/dio.dart';

class CreateDoctorRequest {
  final int userId;
  final String workPlace;
  final String? about;
  final String? location;
  final int? yearsOfExp;
  final dynamic profileImage;
  final dynamic ninDocumentUrl;
  final dynamic licenseDocumentUrl;
  final int? consultationOfferId;
  final List<String>? specializations;
  final List<dynamic>? availabilities;

  CreateDoctorRequest({
    required this.userId,
    required this.workPlace,
    this.about,
    this.location,
    this.yearsOfExp,
    this.profileImage,
    this.ninDocumentUrl,
    this.licenseDocumentUrl,
    this.consultationOfferId,
    this.specializations,
    this.availabilities,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {
      'UserId': userId,
      'WorkPlace': workPlace,
      if (about != null) 'About': about,
      if (location != null) 'Location': location,
      if (yearsOfExp != null) 'YearsOfExp': yearsOfExp,
      if (consultationOfferId != null) 'ConsultationOfferId': consultationOfferId,
    };

    final formData = FormData.fromMap(map);

    if (profileImage != null) {
      if (profileImage is MultipartFile) {
        formData.files.add(MapEntry('ProfileImage', profileImage as MultipartFile));
      } else if (profileImage is String) {
        formData.files.add(MapEntry(
          'ProfileImage',
          await MultipartFile.fromFile(profileImage as String),
        ));
      }
    }

    if (ninDocumentUrl != null) {
      if (ninDocumentUrl is MultipartFile) {
        formData.files.add(MapEntry('NinDocumentUrl', ninDocumentUrl as MultipartFile));
      } else if (ninDocumentUrl is String) {
        formData.files.add(MapEntry(
          'NinDocumentUrl',
          await MultipartFile.fromFile(ninDocumentUrl as String),
        ));
      }
    }

    if (licenseDocumentUrl != null) {
      if (licenseDocumentUrl is MultipartFile) {
        formData.files.add(MapEntry('LicenseDocumentUrl', licenseDocumentUrl as MultipartFile));
      } else if (licenseDocumentUrl is String) {
        formData.files.add(MapEntry(
          'LicenseDocumentUrl',
          await MultipartFile.fromFile(licenseDocumentUrl as String),
        ));
      }
    }

    if (specializations != null) {
      for (final spec in specializations!) {
        formData.fields.add(MapEntry('Specializations', spec));
      }
    }

    if (availabilities != null) {
      for (int i = 0; i < availabilities!.length; i++) {
        final item = availabilities![i];
        if (item is Map) {
          item.forEach((key, val) {
            formData.fields.add(MapEntry('Availabilities[$i].$key', val.toString()));
          });
        }
      }
    }

    return formData;
  }
}
