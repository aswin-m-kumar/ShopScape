import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'screens/detail_screen.dart';
import 'screens/main_shell.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _backgroundColor = Color(0xFF131313);
  static const Color _surfaceColor = Color(0xFF131313);
  static const Color _surfaceContainer = Color(0xFF201F1F);
  static const Color _cardColor = Color(0xFF1C1C1E);
  static const Color _dividerColor = Color(0xFF3A3A3C);
  static const Color _primaryColor = Color(0xFFFFB59D);
  static const Color _primaryContainer = Color(0xFFFF6B35);
  static const Color _onPrimary = Color(0xFF5D1900);
  static const Color _onPrimaryContainer = Color(0xFF5F1900);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'ShopScape',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        darkTheme: _buildTheme(),
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const MainShell(),
          '/detail': (context) => const DetailScreen(),
        },
      ),
    );
  }

  ThemeData _buildTheme() {
    final baseTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        onPrimary: _onPrimary,
        secondary: _primaryContainer,
        onSecondary: _onPrimaryContainer,
        surface: _surfaceColor,
        onSurface: _textPrimary,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      cardColor: _cardColor,
      dividerColor: _dividerColor,
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    final interText = GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
      bodyColor: _textPrimary,
      displayColor: _textPrimary,
    );

    return baseTheme.copyWith(
      textTheme: interText.copyWith(
        headlineLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: _textPrimary),
        headlineMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: _textPrimary),
        headlineSmall: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: _textPrimary),
        titleLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: _textPrimary),
        titleMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: _textPrimary),
        titleSmall: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: _textPrimary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _surfaceColor,
        foregroundColor: _textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: _primaryColor,
        ),
      ),
      chipTheme: baseTheme.chipTheme.copyWith(
        backgroundColor: _surfaceContainer,
        labelStyle: GoogleFonts.inter(color: _textPrimary, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: _dividerColor),
      ),
      cardTheme: CardThemeData(
        color: _cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryColor,
          textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
        ),
      ),
      iconTheme: const IconThemeData(color: _textPrimary),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: _primaryColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: _onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceContainer,
        hintStyle: GoogleFonts.inter(color: _textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
