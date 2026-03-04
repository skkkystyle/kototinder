import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kototinder/core/auth/auth_repository.dart';
import 'package:kototinder/core/auth/auth_service.dart';
import 'package:kototinder/core/di/injection_container.dart';
import 'package:kototinder/presentation/screens/auth_screen.dart';

// Мок-реализация AuthService для тестов
class TestAuthService extends AuthService {
  bool Function(String, String)? onLogin;
  bool Function(String, String)? onRegister;

  TestAuthService() : super(_MockAuthRepository());

  @override
  Future<bool> login(String email, String password) async {
    return onLogin?.call(email, password) ?? false;
  }

  @override
  Future<bool> register(String email, String password) async {
    return onRegister?.call(email, password) ?? true;
  }

  @override
  Future<bool> isLoggedIn() async => false;

  @override
  Future<bool> isOnboardingCompleted() async => false;

  @override
  Future<void> markOnboardingCompleted() async {}

  @override
  Future<void> logout() async {}
}

// Нужен временный мок репозитория
class _MockAuthRepository implements AuthRepository {
  @override
  Future<void> register(String email, String password) async {}

  @override
  Future<bool> validateCredentials(String email, String password) async => false;

  @override
  Future<String?> getStoredEmail() async => null;

  @override
  Future<void> clear() async {}

  @override
  Future<void> saveOnboardingCompleted(bool completed) async {}

  @override
  Future<bool> isOnboardingCompleted() async => false;
}

void main() {
  setUpAll(() {
    // Заменяем реальный DI на тестовый
    getIt.registerFactory<AuthService>(() => TestAuthService());
  });

  tearDownAll(() {
    getIt.reset();
  });

  testWidgets('AuthScreen shows login and sign up buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(),
      ),
    );

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}