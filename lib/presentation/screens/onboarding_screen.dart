import 'package:flutter/material.dart';
import 'package:kototinder/core/di/injection_container.dart';
import 'package:kototinder/core/auth/auth_service.dart';
import 'package:kototinder/presentation/widgets/onboarding_step.dart';

import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final AuthService _authService = getIt<AuthService>();

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      title: "Swipe to Love",
      description: "Swipe left to skip, right to like — Tinder!",
      imagePath: 'assets/images/onboard_1.png',
      icon: Icons.arrow_forward_ios,
    ),
    OnboardingStep(
      title: "Discover Breeds",
      description: "Tap any cat to learn about its breed, personality & origin.",
      imagePath: 'assets/images/onboard_2.png',
      icon: Icons.pets,
    ),
    OnboardingStep(
      title: "Save Favorites",
      description: "Your likes are saved locally — no server needed.",
      imagePath: 'assets/images/onboard_3.png',
      icon: Icons.favorite,
    ),
    OnboardingStep(
      title: "Explore All",
      description: "Browse all cat breeds in the list — find your perfect match!",
      imagePath: 'assets/images/onboard_4.png',
      icon: Icons.list,
    ),
  ];

  final GlobalKey _catKey = GlobalKey();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    final dynamic state = _catKey.currentState;
    state?.restart();
  }

  void _onSkip() async {
    await _authService.markOnboardingCompleted();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  void _onNext() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSkip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _steps.map((step) {
              return _buildStep(step);
            }).toList(),
          ),

          // Индикатор страниц
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _steps.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Color(0xfff9f4fb)
                          : Colors.white.withValues(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Кнопки
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: _currentPage == _steps.length - 1
                    ? _onSkip
                    : _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffa091ee),
                  foregroundColor: Color(0xfff9f4fb),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(_currentPage == _steps.length - 1 ? "Get Started" : "Next"),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: TextButton(
                onPressed: _onSkip,
                child: Text("Skip", style: TextStyle(color: Color(0xfff9f4fb))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(OnboardingStep step) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🐱 Котик с динамическим масштабом
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              final page = _pageController.page ?? 0.0;
              final delta = (page - _currentPage); // отклонение от текущей страницы (-1..0..+1)

              // Чем дальше свайп — тем больше растяжение по X и сжатие по Y
              final scaleX = 1.0 + delta.abs() * 0.8;   // растягивается по ширине
              final scaleY = 1.0 - delta.abs() * 0.8;   // сжимается по высоте

              return Transform.scale(
                scale: 1.0, // общий масштаб можно оставить
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(scaleX, scaleY), // независимое масштабирование
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/cat_static.png', // твой PNG-котик
                    width: 500,
                    height: 500,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 60),
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
        ],
      ),
    );
  }
}