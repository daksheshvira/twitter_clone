import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:twitter_clone/data/models/responser.dart';
import 'package:twitter_clone/data/strings.dart';

class ErrorHandler {
  static Responser<T> error<T>(
    e, {
    StackTrace? stackTrace,
    String? socketError,
    String? noMethod,
    String? typeError,
  }) {
    debugPrint(
      e.toString() + ' ' + stackTrace.toString(),
    );
    switch (e.runtimeType) {
      case SocketException:
        return Responser<T>(
          message: socketError ?? Strings.instance.noInternet,
          isSuccess: false,
        );
      case NoSuchMethodError:
        return Responser<T>(
          message: noMethod ?? Strings.instance.serverError,
          isSuccess: false,
        );
      case TypeError:
        return Responser<T>(
          message: typeError ?? Strings.instance.somethingWrong,
          isSuccess: false,
        );
      default:
        return Responser<T>(message: e.toString(), isSuccess: false);
    }
  }
}
