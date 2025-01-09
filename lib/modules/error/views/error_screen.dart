// import 'package:flutter/material.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatefulWidget {

  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! The page you\'re looking for does not exist.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'It seems you\'ve entered uncharted territory.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go("/");
                // Add your navigation logic here
              },
              child: const Text('Go Back Home'),
            ),
          ],
        ),
      ),
    );
  }
}
