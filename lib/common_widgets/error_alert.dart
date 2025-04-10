import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';

Future<bool?> errorAlert(BuildContext context, String error) async {
  return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Pokedex not able to open',
            style: AppTextStyle.titleBlack,
          ),
          content: Text(
            error,
            style: AppTextStyle.normalBlack,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Try again'))
          ],
        );
      });
}
