import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appStyle {
    // 1. Define Core Color Scheme
    final colorScheme = ColorScheme.light(
      surface: Colors.white,
      primary: const Color(0xFF21212B),
      onPrimary: Colors.white,
      secondary: const Color(0xFFF0F0F4),
      onSecondary: const Color(0xFF7F7F8A),
      outline: Colors.grey.shade400,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          Colors.transparent, // To let the forest background show through
      // 2. Text Theme
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Color(0xFF1A1A1F),
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: -0.2,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF1A1A1F),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),

      // 3. Input Decoration
      // inputDecorationTheme: InputDecorationTheme(
      //   filled: true,
      //   fillColor: Colors.white,
      //   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      //   hintStyle: const TextStyle(color: Color(0xFF9E9EB0), fontSize: 16),
      //   labelStyle: const TextStyle(color: Color(0xFF1A1A1F)),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12.0),
      //     borderSide: BorderSide(color: colorScheme.outline, width: 1.5),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12.0),
      //     borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      //   ),
      // ),

      // 4. Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(48), // Match the tall layout style
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      // 5. Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: const Color(0xFF1A1A1F),
          side: BorderSide(
            color: colorScheme.outline.withAlpha(180),
            width: 1.0,
          ),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      // 6. Card Theme
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 4,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            28.0,
          ), // High rounded corner aesthetic
        ),
      ),
    );
  }
}
