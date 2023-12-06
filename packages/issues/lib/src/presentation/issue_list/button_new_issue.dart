import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';

class ButtonNewIssue extends StatelessWidget {
  const ButtonNewIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.pushNamed('new Issue');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
      ),
      child: const Text('Submit an Issue'),
    );
  }
}
