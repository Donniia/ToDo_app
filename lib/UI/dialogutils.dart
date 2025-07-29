import 'package:flutter/material.dart';
import 'package:to_do/UI/Home/home_screen.dart';

class Dialogutils {
  static void showLoading(BuildContext context, String message,
      {bool isCanceled = true}) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 5,
              ),
              Text(message),
            ],
          ),
        );
      },
      barrierDismissible: isCanceled,
    );
  }

  static void HideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String message,
      {String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      bool isCanceled = true})
  {
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            posAction?.call();
          },
          child: Text(posActionTitle)));
    }
    ;
    if (negActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            negAction?.call();
          },
          child: Text(negActionTitle)));
    }
    showDialog(
      context: context,
      builder: (buildCotext) {
        return AlertDialog(
          actions: actions,
          content: Expanded(child: Text(message)),
        );
      },
      barrierDismissible: isCanceled,
    );
  }
}
