import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kototinder/theme/app_gradients.dart';
import 'screens/home_screen.dart';

import 'config/api_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(
      child: Text("UI error: ${details.summary}", textAlign: TextAlign.center),
    );
  };
  FlutterError.onError = (details) {
    if (kDebugMode) {
      print('Critical error: $details');
    }
  };
  await ApiConfig.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: HomeScreen(),
    );
  }
}
