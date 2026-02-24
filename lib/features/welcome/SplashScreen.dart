import 'package:flutter/material.dart';
import 'package:tasky/features/welcome/wlecome.dart';
import 'package:tasky/features/navigation/main_scrren.dart'; // استيراد الشاشة الرئيسية
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userName = prefs.getString('userName');

      if (!mounted) return;

      if (userName != null && userName.isNotEmpty) {
        // ننتقل لـ MainScrren لكي يظهر الشريط السفلي
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScrren()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Frame.png",
              width: 87,
              height: 87,
            ),
          ],
        ),
      ),
    );
  }
}
