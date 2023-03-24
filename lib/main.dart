import 'package:flutter/material.dart';
import 'package:garage/login/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppColors().toThemeData(),
      home: const LoginPage(),
    );
  }
}

class AppColors {
  Color get primaryColor => const Color(0xff205db9);
  Color get errorColor => const Color(0xff205db9);
  Color get onOtherColor => Colors.white;
  Color get backgroundColor => Colors.white;
  Color get onBackgroundColor => const Color(0xff1B1B1F);

  ThemeData toThemeData() {
    final notoSansTextTheme = GoogleFonts.notoSansArabicTextTheme();
    return ThemeData.light(useMaterial3: false).copyWith(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: onOtherColor,
        secondary: primaryColor,
        onSecondary: onOtherColor,
        error: errorColor,
        onError: onOtherColor,
        background: backgroundColor,
        onBackground: onBackgroundColor,
        surface: backgroundColor,
        onSurface: onBackgroundColor,
      ),
      textTheme: notoSansTextTheme.copyWith(
        displayMedium:
            notoSansTextTheme.displayMedium?.copyWith(color: primaryColor),
        labelMedium: notoSansTextTheme.labelMedium
            ?.copyWith(color: const Color(0xff747474)),
      ),
    );
  }
}
