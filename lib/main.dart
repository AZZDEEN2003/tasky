import 'package:flutter/material.dart';
import 'package:tasky/savices/preferenes_manger.dart';
import 'package:tasky/features/welcome/SplashScreen.dart';
import 'package:tasky/theme/Light_theme.dart';
import 'package:tasky/theme/dark_theme.dart';
import 'package:tasky/theme/theme_controller.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await PreferenesManger().init();
   ThemeController().init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder <ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode themeMode , Widget ? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lighttheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const SplashScreen(),
        );
      }  );
}
}
