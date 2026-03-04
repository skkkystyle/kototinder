import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void registerGlobalErrorHandlers() {
  if (!kReleaseMode) {
    FlutterError.onError = (details) {
      print('Critical error: $details');
    };
  }

  ErrorWidget.builder = (details) {
    return Center(
      child: Text(
        'UI error: ${details.summary}',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      ),
    );
  };
}