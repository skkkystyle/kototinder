import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._();
  factory AnalyticsService() => _instance;
  AnalyticsService._();

  void logEvent(String eventName, {Map<String, dynamic>? params}) {
    final log = {
      'event': eventName,
      'timestamp': DateTime.now().toIso8601String(),
      'params': params ?? {},
    };

    if (kDebugMode) {
      debugPrint('📊 Analytics: $log');
    } else {
    }
  }

  // Удобные методы
  void loginSuccess({String? email}) {
    logEvent('login_success', params: {'email': email});
  }

  void loginError({String? email, String? error}) {
    logEvent('login_error', params: {'email': email, 'error': error});
  }

  void registerSuccess({String? email}) {
    logEvent('register_success', params: {'email': email});
  }

  void registerError({String? email, String? error}) {
    logEvent('register_error', params: {'email': email, 'error': error});
  }
}