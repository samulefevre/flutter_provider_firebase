class Validators {
  //Alphanumeric string that may include _ and – having a length of 3 to 16 characters.
  static final RegExp _displayNameRegExp = RegExp(
    r'^[a-z0-9_-]{3,16}$',
  );
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidDisplayName(String displayName) {
    return _displayNameRegExp.hasMatch(displayName);
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
