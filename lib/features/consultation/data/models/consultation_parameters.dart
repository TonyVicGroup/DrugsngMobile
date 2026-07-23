import 'package:equatable/equatable.dart';

class ConsultationParameters extends Equatable {
  final String? searchTerm;
  final String? status;
  final int pageNumber;
  final int pageSize;

  const ConsultationParameters(
      this.searchTerm, this.status, this.pageNumber, this.pageSize);

  factory ConsultationParameters.initial() => const ConsultationParameters(
        null,
        null,
        0,
        32,
      );

  ConsultationParameters copy({
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
  }) =>
      ConsultationParameters(
        searchTerm,
        status,
        pageNumber ?? this.pageNumber,
        pageSize ?? this.pageSize,
      );

  Map<String, dynamic> toMap() {
    return {
      if (searchTerm != null) "SearchTerm": searchTerm,
      if (status != null) "Status": status,
      "PageNumber": pageNumber,
      "PageSize": pageSize,
    };
  }

  @override
  List<Object?> get props => [
        searchTerm,
        status,
        pageNumber,
        pageSize,
      ];
}
