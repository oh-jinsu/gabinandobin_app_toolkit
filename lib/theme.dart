import 'package:flutter/material.dart';

class GOTheme {
  final Color primaryColor;

  final Color backgroundColor;

  const GOTheme({
    required this.primaryColor,
    this.backgroundColor = Colors.white,
  });

  ThemeData createThemeData() {
    return ThemeData(
      cardColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
      ),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: backgroundColor,
        primary: primaryColor,
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
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}
