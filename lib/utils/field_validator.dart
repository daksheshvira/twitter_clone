/// same function signature as FormTextField's validator;
typedef ValidatorFunction<T> = T Function(T value);

abstract class FieldValidator<T> {
  /// the errorText to display when the validation fails
  final String errorText;

  FieldValidator(this.errorText) : assert(errorText != null);

  /// checks the input against the given conditions
  bool isValid(T value);

  /// call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error errorText
  String? call(T value) {
    return isValid(value) ? null : errorText;
  }
}

abstract class TextFieldValidator extends FieldValidator<String> {
  TextFieldValidator(String errorText) : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  bool get ignoreEmptyValues => true;

  @override
  String? call(String value) {
    return (ignoreEmptyValues && value.isEmpty) ? null : super.call(value);
  }

  /// helper function to check if an input matches a given pattern
  bool hasMatch(String pattern, String input, {bool caseSensitive = true}) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}

class MaxLengthValidator extends TextFieldValidator {
  final int max;

  MaxLengthValidator(this.max, {required String errorText}) : super(errorText);

  @override
  bool isValid(String value) {
    return value.length <= max;
  }

  @override
  String? call(String value) {
    return isValid(value) ? null : errorText;
  }
}
