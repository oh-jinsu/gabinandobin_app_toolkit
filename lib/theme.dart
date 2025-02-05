import 'package:flutter/material.dart';

class GOTheme {
  final Color primaryColor;

  final Color backgroundColor;

  final Color linkColor;

  final Color dividerColor;

  final double fontSize;

  const GOTheme({
    required this.primaryColor,
    required this.fontSize,
    this.backgroundColor = Colors.white,
    this.linkColor = Colors.blue,
    this.dividerColor = const Color(0xffe5e7eb),
  });

  ThemeData createThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      cardColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: backgroundColor,
        primary: primaryColor,
      ),
      dividerColor: dividerColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: primaryColor,
          foregroundColor: backgroundColor,
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith(
            (states) {
              return 0.0;
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300]!,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
        space: 0.0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[100],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 4.0,
        selectedItemColor: primaryColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4.0,
        backgroundColor: primaryColor,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}
