import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xffDFECDB),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(
            0xff5D9CEC,
          ),

          ),
      primaryColor: const Color(0xff5D9CEC),
      colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xff5D9CEC),
          seedColor: const Color(0xff5D9CEC),
          secondary: const Color(0xffFFFFFF),
          onSecondary: const Color(0xff61E757),
          primaryContainer: Colors.white,
          onPrimaryContainer: Colors.white,
        secondaryContainer: Colors.white,
        background: Colors.black
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,

          selectedIconTheme: IconThemeData(color: Color(0xff5D9CEC),size: 20 ),
          unselectedIconTheme:
              IconThemeData(color: Color(0xffC8C9CB), size: 20),
          showSelectedLabels: false,
          showUnselectedLabels: false),
      appBarTheme: const AppBarTheme(
        color: Color(0xff5D9CEC),
        iconTheme: IconThemeData(color: Colors.white, size: 25),
        titleTextStyle: TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
        elevation: 0,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Color(0xff5D9CEC),
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xff61E757),
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xff060E1E),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(
            0xff5D9CEC,
          ),
          ),
      primaryColor: const Color(0xff5D9CEC),
      colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xff5D9CEC),
          seedColor: const Color(0xff5D9CEC),
          secondary: const Color(0xffFFFFFF),
          onSecondary: const Color(0xff61E757),
          primaryContainer: const Color(0xff141922),
          onPrimaryContainer: const Color(0xff141922),
      secondaryContainer:const Color(0xff141922),
      background: Colors.white
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(color: Color(0xff5D9CEC),size: 20),
          selectedItemColor: Color(0xff5D9CEC),
          unselectedIconTheme:
              IconThemeData(color: Color(0xffC8C9CB),size: 20),
          unselectedItemColor: Color(0xffC8C9CB),
          showSelectedLabels: false,
          showUnselectedLabels: false),
      appBarTheme: const AppBarTheme(
          color: Color(0xff5D9CEC),
          iconTheme: IconThemeData(color: Colors.white, size: 25),
          titleTextStyle: TextStyle(
              fontSize: 25,
              color: Color(0xff060E1E),
              fontWeight: FontWeight.w700),
          elevation: 0),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Color(0xff5D9CEC),
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color(0xff61E757),
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ));
}
