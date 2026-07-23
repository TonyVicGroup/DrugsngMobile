import 'package:equatable/equatable.dart';

class DoctorParameters extends Equatable {
  final String? speciality;
  final String? searchTerm;
  final String? status;
  final int? rating;
  final int pageNumber;
  final int pageSize;

  const DoctorParameters(this.speciality, this.searchTerm, this.status,
      this.pageNumber, this.pageSize, this.rating);

  factory DoctorParameters.initial() => const DoctorParameters(
        null,
        null,
        null,
        0,
        32,
        null,
      );

  DoctorParameters copy({
    String? speciality,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    int? rating,
  }) =>
      DoctorParameters(
        speciality,
        searchTerm,
        status,
        pageNumber ?? this.pageNumber,
        pageSize ?? this.pageSize,
        rating ?? this.rating,
      );

  Map<String, dynamic> toMap() {
    return {
      if (speciality?.isNotEmpty ?? false) "Speciality": speciality,
      if (searchTerm?.isNotEmpty ?? false) "SearchTerm": searchTerm,
      if (status?.isNotEmpty ?? false) "Status": status,
      if (rating != null) "Rating": rating,
      "PageNumber": pageNumber,
      "PageSize": pageSize,
    };
  }

  @override
  List<Object?> get props => [
        speciality,
        searchTerm,
        status,
        pageNumber,
        pageSize,
        rating,
      ];
}
