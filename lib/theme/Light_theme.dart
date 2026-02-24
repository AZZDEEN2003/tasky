import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
  ),
  scaffoldBackgroundColor: const Color(0xFFF6F7F9),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFF2AD67B);
      }
      return Colors.transparent;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFFFFFCFC);
      }
      return const Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return const Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  // تم تحديث اللون ليكون أغمق وأوضح في الثيم الفاتح
  dividerTheme: const DividerThemeData(
    color: Color(0xFFBDBDBD), // لون رمادي واضح فوق الخلفية الفاتحة
    thickness: 1,
    space: 30, // مساحة كافية تمنع الاختفاء
    indent: 20, 
    endIndent: 20,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2AD67B),
      foregroundColor: const Color(0xFFFFFCFC),
    ),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Color(0xFF161F1B), fontSize: 28, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(color: Color(0xFF161F1B), fontSize: 24, fontWeight: FontWeight.w400),
    displayLarge: TextStyle(color: Color(0xFF161F1B), fontSize: 32, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    titleSmall: TextStyle(color: Color(0xFF3A4640), fontSize: 14, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(color: Color(0xFF161F1B), fontSize: 16, fontWeight: FontWeight.w400),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontWeight: FontWeight.bold),
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD1DAD6), width: 1)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD1DAD6), width: 1)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD1DAD6), width: 1)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFFF6F7F9),
    selectedItemColor: const Color(0xFF2AD67B),
    unselectedItemColor: Color(0xFF3A4640),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: const TextStyle(
        color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400
    ),
  ),
);
