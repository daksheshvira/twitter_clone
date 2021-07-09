import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  double get inset => MediaQuery.of(this).viewInsets.bottom;

  void showSnackBar(
    String msg, {
    String? actionTitle,
    VoidCallback? onActionCallback,
  }) {
    SnackBarAction? snackBarAction;

    if (actionTitle != null || onActionCallback != null) {
      snackBarAction = SnackBarAction(
          label: actionTitle ?? '', onPressed: onActionCallback ?? () {});
    }

    var fullMsg = msg;

    var snackBar = SnackBar(
      content: Text(
        fullMsg,
        style: GoogleFonts.montserrat(),
      ),
      action: snackBarAction,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showErrorSnackBar(
    String msg, {
    String? actionTitle,
    VoidCallback? onActionCallback,
  }) =>
      showSnackBar(
        msg,
        actionTitle: actionTitle,
        onActionCallback: onActionCallback,
      );

  /// shows alert dialog with circular progressbar along with given text
  void showLoadingIndicator({
    String text = 'Processing...',
    bool isBarrierDismissible = false,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            backgroundColor: Colors.white,
            content: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressIndicator(color: Theme.of(this).buttonColor),
                Text(text),
              ],
            ),
          ),
        );
      },
    );
  }

  /// hides processing
  void removeLoadingIndicator() {
    Navigator.pop(this);
  }
}
