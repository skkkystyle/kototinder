import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get catApiKey => dotenv.env['CAT_API_KEY'] ?? 'DEMO-API-KEY';
  static String get baseUrl => 'https://api.thecatapi.com/v1';
}