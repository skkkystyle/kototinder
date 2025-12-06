import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cat_breed.dart';

class BreedDetailScreen extends StatelessWidget {
  final CatBreed breed;
  final String? imageUrl;

  const BreedDetailScreen({super.key, required this.breed, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xfff9f4fb),
        titleTextStyle: TextStyle(
          color: Color(0xfff9f4fb),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image_not_supported),
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if (imageUrl != null) SizedBox(height: 16),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff9f4fb), width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Color(0xfff9f4fb)),
                  ),
                  SizedBox(height: 4),
                  Text(
                    breed.description ?? 'No description.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xfff9f4fb).withAlpha((0.8 * 255).round()),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffa091ee),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (breed.temperament != null)
                    _buildSection(context, "Personality", breed.temperament!),

                  if (breed.origin != null)
                    _buildSection(context, "Origin", breed.origin!),

                  if (breed.lifeSpan != null)
                    _buildSection(
                      context,
                      "Lifespan",
                      "${breed.lifeSpan} years",
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Color(0xfff9f4fb)),
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xfff9f4fb).withAlpha((0.8 * 255).round()),
            ),
          ),
        ],
      ),
    );
  }
}
