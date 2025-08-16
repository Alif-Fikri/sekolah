import 'package:flutter/material.dart';
import 'package:sekolah/common/bottom_nav.dart';
import 'package:sekolah/screen/home/home_screen.dart';
import 'package:sekolah/screen/home/monitoring/monitoring_screen.dart';
import 'package:sekolah/screen/home/profile_screen.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MonitoringPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        icons: const [
          Icons.home,
          Icons.computer_outlined,
          Icons.person_outline,
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
