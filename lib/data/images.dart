class Images {
  static final Images instance = Images._internal();

  Images._internal();

  factory Images() {
    return instance;
  }

  final _imagePreFix = 'assets/images/';

  String get logo => _imagePreFix + 'logo.png';
}
