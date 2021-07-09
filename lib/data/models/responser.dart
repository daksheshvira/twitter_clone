class Responser<T> {
  final String message;
  final bool isSuccess;
  T? data;

  Responser({
    required this.message,
    required this.isSuccess,
    this.data,
  });
}
