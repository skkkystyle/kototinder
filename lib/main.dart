import 'package:flutter/material.dart';
import 'package:kototinder/core/auth/auth_service.dart';
import 'package:kototinder/core/errors/error_handler.dart';
import 'package:kototinder/presentation/screens/auth_screen.dart';
import 'package:kototinder/presentation/screens/onboarding_screen.dart';
import 'package:kototinder/presentation/theme/app_gradients.dart';
import 'presentation/screens/home_screen.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  final authService = getIt<AuthService>();
  final isLoggedIn = await authService.isLoggedIn();
  final onboardingCompleted = await authService.isOnboardingCompleted();

  registerGlobalErrorHandlers();
  runApp(MyApp(
      showOnboarding: !onboardingCompleted && !isLoggedIn,
      isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  final bool isLoggedIn;
  const MyApp({super.key, required this.showOnboarding, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Color(0xfff9f4fb),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),

        extensions: <ThemeExtension<dynamic>>[AppGradients.defaultGradients],
      ),
      builder: (context, child) {
        final gradients = Theme.of(
          context,
        ).extension<AppGradients>()?.primaryGradient;

        return Container(
          decoration: BoxDecoration(gradient: gradients),
          child: child,
        );
      },
      home: showOnboarding
          ? OnboardingScreen()
          : (isLoggedIn ? HomeScreen() : AuthScreen()),
    );
  }
}
