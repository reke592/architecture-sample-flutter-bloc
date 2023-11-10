import 'package:flutter/material.dart';

class MessageDialog {
  static Future<void> showError(BuildContext context, Object error) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Error'),
        content: Text('$error'),
        actions: [
          Center(
            child: IconButton(
              onPressed: () => Navigator.pop(dialogContext),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
