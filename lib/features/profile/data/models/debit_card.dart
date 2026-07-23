import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DebitCard extends Equatable {
  static const _idKey = "id";
  static const _nameOnCardKey = "nameOnCard";
  static const _cardNumberKey = "cardNumber";
  static const _expiryDateKey = "expiryDate";
  static const _cvcKey = "cvc";
  static const _userIdKey = "userId";
  static const _userFullNameKey = "userFullName";

  final int id;
  final String nameOnCard;
  final String cardNumber;
  final DateTime expiryDate;
  final String cvc;
  final int userId;
  final String userFullName;

  const DebitCard({
    required this.id,
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvc,
    required this.userId,
    required this.userFullName,
  });

  factory DebitCard.fromJson(Map<String, dynamic> json) {
    return DebitCard(
      id: json[_idKey],
      nameOnCard: json[_nameOnCardKey],
      cardNumber: json[_cardNumberKey],
      expiryDate: DateTime.tryParse(json[_expiryDateKey]) ?? DateTime.now(),
      cvc: json[_cvcKey],
      userId: json[_userIdKey],
      userFullName: json[_userFullNameKey],
    );
  }

  Map<String, dynamic> toJson() => {
        _nameOnCardKey: nameOnCard,
        _cardNumberKey: cardNumber,
        _expiryDateKey: DateFormat('MM-yy').format(expiryDate),
        _cvcKey: cvc,
      };

  @override
  List<Object?> get props => [
        id,
        nameOnCard,
        cardNumber,
        expiryDate,
        cvc,
        userId,
        userFullName,
      ];
}
