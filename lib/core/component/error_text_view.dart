import 'package:flutter/material.dart';

class ErrorTextView extends StatelessWidget {
  const ErrorTextView({
    super.key,
    required this.errorText,
  });
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        errorText ?? "",
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
