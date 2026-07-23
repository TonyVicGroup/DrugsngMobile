class AppValidators {
  static final _emailRegex = RegExp(
    r"^[-!#$%&'*+/0-9=?A-Z^_a-z{|}~](\.?[-!#$%&'*+/0-9=?A-Z^_a-z{|}~])*@[a-zA-Z](-?[a-zA-Z0-9])*(\.[a-zA-Z](-?[a-zA-Z0-9])*)+$",
  );

  static final _phoneRegex = RegExp(r"^\+?[0-9]\d{1,20}$");

  // static final _password = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  static String? name(
    String? text, [
    String warningText = "Enter a valid name",
  ]) => (text?.length ?? 0) <= 2 ? warningText : null;

  static String? email(String? text) =>
      _emailRegex.hasMatch(text ?? "") ? null : "Enter a valid email";

  static String? phone(String? text) =>
      _phoneRegex.hasMatch(text ?? "") ? null : "Enter a valid phone number";

  static String? passwordStrong(String? text) {
    if (text == null || text.length < 8) {
      return "Password must be at least 8 characters long";
    }

    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharRegex.hasMatch(text)) {
      return "Password must contain at least one special character";
    }

    return null;
  }

  static String? password(String? text) =>
      (text?.length ?? 0) > 4
          ? null
          : "Password must be at least 4 characters long";

  static String? notNull(
    dynamic value, [
    String warningText = "Enter a valid value",
  ]) => value != null ? null : warningText;

  static String? doubleNum(
    String? text, {
    String warningText = "Enter a valid number",
    String minWarnText = 'Enter a larger number',
    String maxWarnText = 'Enter a smaller number',
    double? min,
    double? max,
  }) {
    final result = double.tryParse(text ?? '');
    if (result == null) {
      return warningText;
    } else {
      if (min != null && result <= min) {
        return minWarnText;
      }
      if (max != null && result > max) {
        return maxWarnText;
      }
    }
    return null;
  }

  static String? intNum(
    String? text, {
    String warningText = "Enter a valid number",
    String minWarnText = 'Enter a larger number',
    String maxWarnText = 'Enter a smaller number',
    double? min,
    double? max,
  }) {
    final result = int.tryParse(text ?? '');
    if (result == null) {
      return warningText;
    } else {
      if (min != null && result < min) {
        return minWarnText;
      }
      if (max != null && result > max) {
        return maxWarnText;
      }
    }
    return null;
  }

  static String? intCount(
    String? text,
    int count, [
    warningText = 'Enter a valid number',
  ]) {
    final result = int.tryParse(text ?? '');
    if (result == null) {
      return warningText;
    } else if ((text ?? '').length != count) {
      return warningText;
    }
    return null;
  }
}
