import 'package:flutter_test/flutter_test.dart';
import 'package:kototinder/core/auth/auth_service.dart';
import 'package:mockito/mockito.dart';

// Подключаем сгенерированный мок
import 'mock_auth_repository.mocks.dart'; // ← Смотри на имя файла!

void main() {
  late MockAuthRepository mockRepo;
  late AuthService authService;

  setUp(() {
    mockRepo = MockAuthRepository(); // ← теперь это настоящий мок
    authService = AuthService(mockRepo);
  });

  group('AuthService', () {
    test('login returns true if credentials match', () async {
      // Устанавливаем поведение мока
      when(mockRepo.validateCredentials('test@test.com', '123456'))
          .thenAnswer((_) async => true);

      final result = await authService.login('test@test.com', '123456');
      expect(result, isTrue);
    });

    test('login returns false if credentials mismatch', () async {
      when(mockRepo.validateCredentials('test@test.com', 'wrong'))
          .thenAnswer((_) async => false);

      final result = await authService.login('test@test.com', 'wrong');
      expect(result, isFalse);
    });

    test('isLoggedIn returns true if email stored', () async {
      when(mockRepo.getStoredEmail())
          .thenAnswer((_) async => 'test@test.com');

      final result = await authService.isLoggedIn();
      expect(result, isTrue);
    });

    test('isLoggedIn returns false if no email', () async {
      when(mockRepo.getStoredEmail())
          .thenAnswer((_) async => null);

      final result = await authService.isLoggedIn();
      expect(result, isFalse);
    });
  });
}