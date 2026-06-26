import 'package:flutter/material.dart';
import 'package:movix/features/home/presentation/screens/home_screen.dart';
import 'package:movix/features/profile/presentation/screens/profile_screen.dart';

import 'package:movix/core/theme/app_colors.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Discover - Coming Soon', style: TextStyle(color: Colors.white, fontSize: 24))),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          fixedColor: Colors.white,
          selectedFontSize: 16,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: AppColors.grey,
          unselectedItemColor: AppColors.textSecondary,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            customButtonItem("assets/icons/home.png", ""),
            customButtonItem("assets/icons/discover.png", ""),
            customButtonItem("assets/icons/profile.png", ""),
          ]),
    );
  }

  BottomNavigationBarItem customButtonItem(String image, String label) {
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(image)),
        label: label,
        activeIcon: Container(
          width: 60,
          height: 35,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: ImageIcon(
            AssetImage(image),
            color: Colors.yellow,
          ),
        ));
  }
}
