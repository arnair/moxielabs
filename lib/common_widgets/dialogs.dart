import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';

/// Shows an error dialog with a custom title and message
Future<bool?> showErrorDialog(
  BuildContext context, {
  required String title,
  required String message,
  String buttonText = 'OK',
}) async {
  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppTextStyle.titleBlack,
        ),
        content: Text(
          message,
          style: AppTextStyle.normalBlack,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}

/// Shows a confirmation dialog with custom title, message and action buttons
Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
}) async {
  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppTextStyle.titleBlack,
        ),
        content: Text(
          message,
          style: AppTextStyle.normalBlack,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}

/// Shows a loading dialog with a custom message
void showLoadingDialog(
  BuildContext context, {
  String message = 'Loading...',
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(
              message,
              style: AppTextStyle.normalBlack,
            ),
          ],
        ),
      );
    },
  );
}
