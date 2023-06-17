import 'package:digiquran/common/color.dart';
import 'package:digiquran/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});
  static const routeName = '/navigation-widget';

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _selectedIndex = 0;
  final List _widgetOptions = [
    const HomeScreen(),
    const Center(child: Text('Quran')),
    const Center(child: Text('Hadith')),
    const Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: secondaryColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: tertiaryColor.withOpacity(.5),
          items: [
            _selectedIndex == 0
                ? const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.house_fill),
                    label: 'Home',
                  )
                : const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.house),
                    label: 'Home',
                  ),
            _selectedIndex == 1
                ? const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.search_heart_fill),
                    label: 'Quran',
                  )
                : const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.search_heart),
                    label: 'Quran',
                  ),
            _selectedIndex == 2
                ? const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.play_circle_fill),
                    label: 'Hadith',
                  )
                : const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.play_circle),
                    label: 'Video',
                  ),
            _selectedIndex == 3
                ? const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.person_fill),
                    label: 'Video',
                  )
                : const BottomNavigationBarItem(
                    icon: Icon(Bootstrap.person),
                    label: 'Profile',
                  ),
          ],
        ),
      ),
    );
  }
}
