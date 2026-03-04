abstract class AuthRepository {
  Future<void> register(String email, String password);
  Future<bool> validateCredentials(String email, String password);
  Future<String?> getStoredEmail();
  Future<void> clear();
  Future<void> saveOnboardingCompleted(bool completed);
  Future<bool?> isOnboardingCompleted();
}

