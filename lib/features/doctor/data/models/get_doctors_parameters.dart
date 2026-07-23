import 'package:equatable/equatable.dart';

class GetDoctorsParameters extends Equatable {
  final String? speciality;
  final String? location;
  final int? rating;
  final String? searchTerm;
  final String? status;
  final int? pageNumber;
  final int? pageSize;
  final bool? pendingRequest;

  const GetDoctorsParameters({
    this.speciality,
    this.location,
    this.rating,
    this.searchTerm,
    this.status,
    this.pageNumber,
    this.pageSize,
    this.pendingRequest,
  });

  Map<String, dynamic> toMap() {
    return {
      if (speciality?.isNotEmpty ?? false) 'Speciality': speciality,
      if (location?.isNotEmpty ?? false) 'Location': location,
      if (rating != null) 'Rating': rating,
      if (searchTerm?.isNotEmpty ?? false) 'SearchTerm': searchTerm,
      if (status?.isNotEmpty ?? false) 'Status': status,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };
  }

  @override
  List<Object?> get props => [
        speciality,
        location,
        rating,
        searchTerm,
        status,
        pageNumber,
        pageSize,
        pendingRequest,
      ];
}
