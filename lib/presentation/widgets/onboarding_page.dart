import 'package:flutter/material.dart';

import 'onboarding_step.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingStep step;

  const OnboardingPage({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Icon(step.icon, size: 80, color: Color(0xffa091ee)),
          ),
          SizedBox(height: 32),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Color(0xfff9f4fb),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xfff9f4fb).withAlpha(200),
            ),
          ),
          SizedBox(height: 48),
          FadeInImage(
            placeholder: AssetImage('assets/images/placeholder.png'),
            image: AssetImage(step.imagePath),
            height: 250,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}