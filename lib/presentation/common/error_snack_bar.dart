import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  final String text;

  ErrorSnackBar(this.text, {super.key})
      : super(
          content: ErrorSnackBarContent(text),
          backgroundColor: Colors.red,
        );
}

class ErrorSnackBarContent extends StatelessWidget {
  final String text;

  const ErrorSnackBarContent(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.error_outline),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
