import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
  ),
  scaffoldBackgroundColor: const Color(0xFF181818),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF181818),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2AD67B),
      foregroundColor: const Color(0xFFFFFCFC),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: Color(0xFF6D6D6D),
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: const Color(0xFF2A2A2A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Color(0xFFFFFFFF), fontSize: 28, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w400),
    displayLarge: TextStyle(color: Color(0xFFFFFCFC), fontSize: 32, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    titleSmall: TextStyle(color: Color(0xFFC6C6C6), fontSize: 14, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(color: Color(0xFFFFFCFC), fontSize: 16, fontWeight: FontWeight.w400),
  ),
  // تم تحديث اللون والمسافات هنا لضمان الوضوح والثبات
  dividerTheme: const DividerThemeData(
    color: Color(0xFFCAC4D0), // لون فاتح واضح جداً في الوضع الغامق
    thickness: 1,
    space: 30, // مساحة عمودية أكبر تمنع الاختفاء
    indent: 20, 
    endIndent: 20,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF181818),
    selectedItemColor: const Color(0xFF2AD67B),
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
popupMenuTheme: PopupMenuThemeData(
  color: const Color(0xFF181818),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400
  ),

),
);
