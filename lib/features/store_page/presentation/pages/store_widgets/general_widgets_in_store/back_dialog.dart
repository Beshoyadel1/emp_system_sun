import 'package:flutter/material.dart';

Future<bool?> showBackDialog({required BuildContext context}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: const SizedBox(
          width: 300,
          child: Center(
            child: Text(
              "Confirm_Exit",
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: const SizedBox(
          height: 50,
          width: 300,
          child: Center(
            child: Text(
              "Are_You_Sure_To_Leave",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("OK"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Cancel"),
                ),
              ]),
        ],
      );
    },
  );
}
