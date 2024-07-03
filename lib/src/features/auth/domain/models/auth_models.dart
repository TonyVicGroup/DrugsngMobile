class RegisterData {
  final String firstName, lastName, emailAddress, password;

  RegisterData({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.password,
  });
}

class SetNewPasswordData {
  final String newPassword, token, userId;

  SetNewPasswordData({
    required this.newPassword,
    required this.token,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "newPassword": newPassword,
        "confirmPassword": newPassword,
        "token": token,
      };
}
