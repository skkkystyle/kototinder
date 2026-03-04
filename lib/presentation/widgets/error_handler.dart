import 'package:flutter/material.dart';

class ErrorHandler {
  static void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Error", style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  static String getErrorMessage(Object error) {
    if (error is ArgumentError) {
      return "Invalid request. Please try again later.";
    }
    if (error.toString().contains("SocketException") ||
        error.toString().contains("Failed host lookup")) {
      return "No internet connection. Please check your network.";
    }
    if (error.toString().contains("401")) {
      return "Unauthorized access to API. Check API key.";
    }
    if (error.toString().contains("404")) {
      return "Requested resource was not found.";
    }
    if (error.toString().contains("429")) {
      return "Too many requests. Please try again later.";
    }
    if (error.toString().contains("500")) {
      return "Server internal error. Please try again later.";
    }
    return "An unexpected error occurred: $error";
  }

  static void handle(Exception exception, BuildContext context) {
    final message = getErrorMessage(exception);
    showErrorMessage(context, message);
  }
}
