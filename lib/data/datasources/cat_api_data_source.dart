import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cat_image_model.dart';
import '../models/cat_breed_model.dart';
import '../../config/api_config.dart';

class CatApiDataSource {
  static const String baseUrl = 'https://api.thecatapi.com/v1';

  Future<CatImageModel> getRandomCat() async {
    final response = await http.get(
      Uri.parse('$baseUrl/images/search?limit=1&has_breeds=1&order=RANDOM'),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      if (data.isNotEmpty) {
        return CatImageModel.fromJson(data[0]);
      } else {
        throw Exception('No cat image returned');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  }

  Future<List<CatImageModel>> getRandomCats(int limit) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/images/search?limit=$limit&has_breeds=1&order=RANDOM',
      ),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => CatImageModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cats: ${response.statusCode}');
    }
  }

  Future<List<CatBreedModel>> getAllBreeds() async {
    final response = await http.get(
      Uri.parse('$baseUrl/breeds'),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => CatBreedModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load breeds: ${response.statusCode}');
    }
  }

  Future<CatBreedModel> getBreedById(String breedId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/breeds/$breedId'),
      headers: {'x-api-key': ApiConfig.catApiKey},
    );

    if (response.statusCode == 200) {
      return CatBreedModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load breed: ${response.statusCode}');
    }
  }
}
