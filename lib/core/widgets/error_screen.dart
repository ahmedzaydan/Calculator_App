import 'package:flutter/material.dart';

// Error Screen for uncaught errors
class ErrorScreen extends StatelessWidget {
  final String error;
  final String? stackTrace;

  const ErrorScreen({
    Key? key,
    required this.error,
    this.stackTrace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'An Error Occurred!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  child: Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                if (stackTrace != null) ...[
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    child: Text(
                      stackTrace!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
