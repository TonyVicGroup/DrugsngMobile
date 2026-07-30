import 'package:equatable/equatable.dart';

class TitleAndDescription extends Equatable {
  const TitleAndDescription({required this.title, required this.description});

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}
