import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cat_image.dart';
import '../models/cat_breed.dart';
import '../config/api_config.dart';

class CatApiService {
  static const String baseUrl = 'https://api.thecatapi.com/v1';

  Future<CatImage> getRandomCat() async {
    final response = await http.get(
      Uri.parse('$baseUrl/images/search?limit=1&has_breeds=1&order=RANDOM'),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      if (data.isNotEmpty) {
        return CatImage.fromJson(data[0]);
      } else {
        throw Exception('No cat image returned');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  }

  Future<List<CatImage>> getRandomCats(int limit) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/images/search?limit=$limit&has_breeds=1&order=RANDOM',
      ),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => CatImage.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cats: ${response.statusCode}');
    }
  }

  Future<List<CatBreed>> getAllBreeds() async {
    final response = await http.get(
      Uri.parse('$baseUrl/breeds'),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => CatBreed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load breeds: ${response.statusCode}');
    }
  }

  Future<CatBreed> getBreedById(String breedId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/breeds/$breedId'),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      return CatBreed.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load breed: ${response.statusCode}');
    }
  }
}
