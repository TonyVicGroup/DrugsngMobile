class AppValidators {
  static final _emailRegex = RegExp(
      r"^[-!#$%&'*+/0-9=?A-Z^_a-z{|}~](\.?[-!#$%&'*+/0-9=?A-Z^_a-z{|}~])*@[a-zA-Z](-?[a-zA-Z0-9])*(\.[a-zA-Z](-?[a-zA-Z0-9])*)+$");

  static final _phoneRegex = RegExp(r"^\+?[0-9]\d{1,20}$");

  static final _password = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  static String? email(String? text) =>
      _emailRegex.hasMatch(text ?? "") ? null : "Enter a valid email";

  static String? phone(String? text) =>
      _phoneRegex.hasMatch(text ?? "") ? null : "Enter a valid phone number";

  static String? password(String? text) => _password.hasMatch(text ?? "")
      ? null
      : "Password must be more than 8 characters with text and numbers";
}
