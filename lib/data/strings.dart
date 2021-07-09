class Strings {
  static final Strings instance = Strings._internal();

  Strings._internal();

  factory Strings() {
    return instance;
  }

  String get signUp => 'Sign Up';

  String get login => 'Login';

  String get noInternet => 'No internet, please check your connection!';

  String get sessionExpired =>
      'You have been logged out of your account, please login again to continue';

  String get somethingWrong => 'Something went wrong. Please try again later!';

  String get serverError => 'Server Error! Please try again later.';
}
