import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';

class GOColorScheme {
  final Color primaryColor;

  final Color backgroundColor;

  final Color linkColor;

  final Color dividerColor;

  const GOColorScheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.linkColor,
    required this.dividerColor,
  });

  factory GOColorScheme.light({
    required Color primaryColor,
    Color backgroundColor = Colors.white,
    Color linkColor = Colors.blue,
    Color dividerColor = const Color(0xffe5e7eb),
  }) {
    return GOColorScheme(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      linkColor: linkColor,
      dividerColor: dividerColor,
    );
  }

  factory GOColorScheme.dark({
    required Color primaryColor,
    Color backgroundColor = Colors.black,
    Color linkColor = Colors.blue,
    Color dividerColor = const Color(0xff3f3f46),
  }) {
    return GOColorScheme(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      linkColor: linkColor,
      dividerColor: dividerColor,
    );
  }

  GOColorScheme copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? linkColor,
    Color? dividerColor,
  }) {
    return GOColorScheme(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      linkColor: linkColor ?? this.linkColor,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }
}

class GOThemeData {
  final GOColorScheme light;

  final GOColorScheme dark;

  final double fontSize;

  final Map<int, Color> gray;

  const GOThemeData({
    required this.light,
    required this.dark,
    required this.fontSize,
    this.gray = defaultGray,
  });
}

enum GOThemeMode {
  light,
  dark,
}

class GOThemeController extends GOController {
  final GOThemeData data;

  GOThemeMode mode;

  GOThemeController({
    required this.data,
    required this.mode,
  });

  GOColorScheme get colorScheme {
    return mode == GOThemeMode.light ? data.light : data.dark;
  }

  Color get primaryColor {
    return colorScheme.primaryColor;
  }

  Color get backgroundColor {
    return colorScheme.backgroundColor;
  }

  Color get linkColor {
    return colorScheme.linkColor;
  }

  Color get dividerColor {
    return colorScheme.dividerColor;
  }

  double get fontSize {
    return data.fontSize;
  }

  Map<int, Color> get gray {
    return data.gray;
  }

  void setMode(GOThemeMode mode) {
    this.mode = mode;

    notifyListeners();
  }

  ThemeData generateThemeData() {
    return ThemeData(
      primaryColor: colorScheme.primaryColor,
      cardColor: colorScheme.backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: colorScheme.backgroundColor,
        primary: colorScheme.primaryColor,
      ),
      dividerColor: colorScheme.dividerColor,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.backgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: colorScheme.primaryColor,
          foregroundColor: colorScheme.backgroundColor,
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
          foregroundColor: colorScheme.primaryColor,
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
        selectedItemColor: colorScheme.primaryColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4.0,
        backgroundColor: colorScheme.primaryColor,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: data.fontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
      scaffoldBackgroundColor: colorScheme.backgroundColor,
    );
  }
}

const Map<int, Color> defaultGray = {
  50: Color(0xfff9fafb),
  100: Color(0xfff3f4f6),
  200: Color(0xffe5e7eb),
  300: Color(0xffd1d5db),
  400: Color(0xff9ca3af),
  500: Color(0xff6b7280),
  600: Color(0xff4b5563),
  700: Color(0xff3f3f46),
  800: Color(0xff1f2937),
  900: Color(0xff18181b),
  950: Color(0xff09090b),
};
