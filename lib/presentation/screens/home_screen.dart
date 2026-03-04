import 'package:flutter/material.dart';
import 'breed_list_screen.dart';
import 'main_cat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    MainCatScreen(),
    BreedsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Breeds"),
        ],
        backgroundColor: Color(0xffa091ee),
        selectedItemColor: Color(0xfff9f4fb),
        unselectedItemColor: Color(0xffdfdfff),
      ),
    );
  }
}
