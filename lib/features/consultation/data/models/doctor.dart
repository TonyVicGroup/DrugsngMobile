import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  static const String _idKey = "id";
  static const String _fullNameKey = "fullName";
  static const String _specialityKey = "speciality";
  static const String _workPlaceKey = "workPlace";
  static const String _ratingKey = "rating";
  static const String _yearsOfExpKey = "yearsOfExp";
  static const String _profileImageKey = "profileImage";

  final int id;
  final String fullName;
  final String speciality;
  final String workPlace;
  final double rating;
  final int yearsOfExp;
  final String profileImage;

  const Doctor({
    required this.id,
    required this.fullName,
    required this.speciality,
    required this.workPlace,
    required this.rating,
    required this.yearsOfExp,
    required this.profileImage,
  });

  factory Doctor.fromJson(Map json) {
    num id = json[_idKey];
    num rating = json[_ratingKey] ?? 0;
    num yearsOfExp = json[_yearsOfExpKey] ?? 0;
    return Doctor(
      id: id.toInt(),
      fullName: json[_fullNameKey] ?? 'Doctor',
      speciality: json[_specialityKey] ?? 'Health',
      workPlace: json[_workPlaceKey],
      rating: rating.toDouble(),
      yearsOfExp: yearsOfExp.toInt(),
      profileImage: json[_profileImageKey] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        speciality,
        workPlace,
        rating,
        yearsOfExp,
        profileImage,
      ];
}
