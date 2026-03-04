import '../analytics/analytics_service.dart';
import '../di/injection_container.dart';
import 'auth_repository.dart';

class AuthService {
  final AuthRepository _repository;
  final AnalyticsService _analytics;

  AuthService(this._repository, {AnalyticsService? analytics})
      : _analytics = analytics ?? getIt<AnalyticsService>();

  Future<void> markOnboardingCompleted() async {
    await _repository.saveOnboardingCompleted(true);
  }

  Future<bool> isOnboardingCompleted() async {
    return await _repository.isOnboardingCompleted() ?? false;
  }

  Future<bool> register(String email, String password) async {
    if (email.isEmpty || password.length < 6) {
      return false;
    }
    try {
      await _repository.register(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final isValid = await _repository.validateCredentials(email, password);
      if (isValid) {
        _analytics.loginSuccess(email: email);
        return true;
      } else {
        _analytics.loginError(email: email, error: 'Invalid credentials');
        return false;
      }
    } catch (e) {
      _analytics.loginError(email: email, error: e.toString());
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final email = await _repository.getStoredEmail();
    return email != null;
  }

  Future<void> logout() async {
    await _repository.clear();
  }
}