import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_repository.dart';

class SecureStorageAuthRepository implements AuthRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static final Encrypter _encrypter = Encrypter(AES(Key.fromLength(32)));

  @override
  Future<void> register(String email, String password) async {
    final iv = IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(password, iv: iv);

    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_password', value: encrypted.base64);
    await _storage.write(key: 'user_iv', value: iv.base64);
  }

  @override
  Future<bool> validateCredentials(String email, String password) async {
    final storedEmail = await _storage.read(key: 'user_email');
    final storedPassword = await _storage.read(key: 'user_password');
    final storedIv = await _storage.read(key: 'user_iv');

    if (storedEmail != email || storedPassword == null || storedIv == null) return false;

    try {
      final iv = IV.fromBase64(storedIv);
      final decrypted = _encrypter.decrypt64(storedPassword, iv: iv);
      return decrypted == password;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getStoredEmail() async {
    return await _storage.read(key: 'user_email');
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: 'user_email');
    await _storage.delete(key: 'user_password');
  }

  @override
  Future<void> saveOnboardingCompleted(bool completed) async {
    await _storage.write(key: 'onboarding_completed', value: completed.toString());
  }

  @override
  Future<bool?> isOnboardingCompleted() async {
    final value = await _storage.read(key: 'onboarding_completed');
    return value == 'true';
  }
}