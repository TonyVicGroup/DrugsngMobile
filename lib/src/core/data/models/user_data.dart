import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String name;
  final String id;
  final String imgUrl;
  final String phoneNumber;
  final String email;
  final String gender;
  final DateTime date;

  const UserData({
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.date,
  });

  @override
  List<Object?> get props =>
      [name, id, imgUrl, phoneNumber, email, gender, date];
}
