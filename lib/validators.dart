class Validators {
  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegExp.hasMatch(email);
  }

  static bool isValidName(String name) {
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(name) && name.trim().length >= 3;
  }

  static bool isValidDate(DateTime date) {
    final now = DateTime.now();
    final minimumAge = 16;
    final maximumAge = 100;

    final minimumDate = DateTime(now.year - maximumAge);
    final maximumDate = DateTime(now.year - minimumAge);

    return date.isAfter(minimumDate) && date.isBefore(maximumDate);
  }
}