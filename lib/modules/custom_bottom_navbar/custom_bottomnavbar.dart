
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class MaterialYouBottomNavBar extends StatefulWidget {
  const MaterialYouBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MaterialYouBottomNavBar> createState() => _MaterialYouState();
}

class _MaterialYouState extends State<MaterialYouBottomNavBar> {
  int _currentIndex = 0;
  List<Widget> pages = const [
    Text('eco', style: _textStyle),
    Text('home', style: _textStyle),
    Text('person', style: _textStyle),
    Text('video', style: _textStyle),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationBar'),
      ),
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.teal.withOpacity(0.3),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),
        child: NavigationBar(
          animationDuration: Duration(seconds: 1),
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.eco),
              icon: Icon(Icons.eco_outlined),
              label: 'eco',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: 'person',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.video_camera_back),
              icon: Icon(Icons.video_camera_back_outlined),
              label: 'video',
            ),
          ],
        ),
      ),
    );
  }
}