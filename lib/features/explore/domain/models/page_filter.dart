import 'package:equatable/equatable.dart';

class PageFilter extends Equatable {
  static const String _pageNumberKey = "pageNumber";
  static const String _pageSizeKey = "pageSize";

  final int pageNumber;
  final int pageSize;

  const PageFilter({required this.pageNumber, required this.pageSize});

  Map<String, dynamic> toJson() => {
        _pageNumberKey: pageNumber,
        _pageSizeKey: pageSize,
      };

  @override
  List<Object?> get props => [pageNumber, pageSize];
}
