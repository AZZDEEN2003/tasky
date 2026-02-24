import 'package:flutter/material.dart';
import 'package:tasky/scerrnapp/HomeScerrn.dart';
import 'package:tasky/scerrnapp/todo_scrren.dart';
import 'package:tasky/scerrnapp/Profile_scrren.dart';
import 'package:tasky/scerrnapp/complet_scrren.dart';
import '../theme/theme_controller.dart';

class MainScrren extends StatefulWidget {
  const MainScrren({super.key});

  @override
  State<MainScrren> createState() => _MainScrrenState();
}

class _MainScrrenState extends State<MainScrren> {
  final List<Widget> screens = [
     const Homescerrn(),
     const TodoScrren(),
     const CompletScrren(),
     const ProfileScrren()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // تعريف اللون بناءً على حالة الثيم لتسهيل استخدامه
    final Color iconColor = ThemeController.themeNotifier.value == ThemeMode.dark 
        ? Colors.white 
        : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        selectedItemColor: const Color(0xFF2AD67B),
        // تم توحيد منطق الألوان هنا أيضاً
        unselectedItemColor: iconColor.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: iconColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/To.png", 
              width: 24, 
              color: iconColor
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: iconColor),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: iconColor),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[currentIndex]),
    );
  }
}
