import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static late final String catApiKey;

  static Future<void> init() async {
    await dotenv.load(fileName: "assets/.env");
    catApiKey = dotenv.get('CAT_API_KEY');
  }
}
