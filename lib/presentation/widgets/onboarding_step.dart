import 'package:flutter/cupertino.dart';

class OnboardingStep {
  final String title;
  final String description;
  final String imagePath;
  final IconData icon;

  const OnboardingStep({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.icon,
  });
}