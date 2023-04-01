import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:garage/home/home_page.dart';
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
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale("fa", "IR")],
      locale: const Locale("fa", "IR"),
      theme: AppColors().toThemeData(),
      home: const LoginPage(),
    );
  }
}

class AppColors {
  Color get primaryColor => const Color(0xff205db9);
  Color get secondaryColor => const Color(0xff545E79);
  Color get errorColor => const Color(0xffBA1A1A);
  Color get onOtherColor => Colors.white;
  Color get backgroundColor => Colors.white;
  Color get primaryContainerColor => const Color(0xffDAE2FF);
  Color get onBackgroundColor => const Color(0xff1B1B1F);
  Color get onSurfaceVariantColor => const Color(0xff44464F);

  ThemeData toThemeData() {
    final notoSansTextTheme = GoogleFonts.notoSansArabicTextTheme();

    var textTheme = notoSansTextTheme.copyWith(
      titleSmall: notoSansTextTheme.titleSmall?.copyWith(color: secondaryColor),
      titleMedium: notoSansTextTheme.titleMedium?.copyWith(color: onBackgroundColor),
      displayMedium: notoSansTextTheme.displayMedium?.copyWith(color: primaryColor),
      labelMedium: notoSansTextTheme.labelMedium?.copyWith(color: const Color(0xff747474)),
    );

    return ThemeData.light(useMaterial3: false).copyWith(
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: onOtherColor,
          secondary: secondaryColor,
          onSecondary: onOtherColor,
          error: errorColor,
          onError: onOtherColor,
          background: backgroundColor,
          onBackground: onBackgroundColor,
          surface: backgroundColor,
          onSurface: onBackgroundColor,
          primaryContainer: primaryColor,
          onSurfaceVariant: onSurfaceVariantColor),
      tabBarTheme: TabBarTheme(
          labelColor: onSurfaceVariantColor,
          unselectedLabelColor: onSurfaceVariantColor,
          unselectedLabelStyle: textTheme.titleSmall,
          labelStyle: textTheme.titleSmall,
          indicatorSize: TabBarIndicatorSize.label,
          indicator:
              BoxDecoration(color: primaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)))),
      textTheme: textTheme,
    );
  }
}
