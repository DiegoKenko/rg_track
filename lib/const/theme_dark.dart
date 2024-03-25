import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rg_track/const/theme.dart';

const Color _textColor = Colors.white;
const Color _inputInfoColor = Colors.white;

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    shadowColor: Colors.red.withOpacity(0.5),
    focusColor: Colors.white,
    dataTableTheme: DataTableThemeData(
      dataTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      dataRowMaxHeight: 50,
      dataRowMinHeight: 30,
      columnSpacing: kIsWeb ? 20 : 12,
      headingTextStyle: const TextStyle(
        letterSpacing: 1.5,
        color: primaryColor,
        fontSize: 15,
      ),
      headingRowHeight: 32,
      headingRowColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) => Colors.grey.shade300),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      elevation: MaterialStateProperty.all(0.0),
      fixedSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
      padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide.none,
      )),
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      textStyle:
          MaterialStateProperty.all(const TextStyle(color: Colors.white)),
    )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 24)),
          textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.red))),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: _inputInfoColor,
      selectionColor: _inputInfoColor,
      selectionHandleColor: _inputInfoColor,
    ),
    primaryIconTheme: const IconThemeData(color: primaryColor),
    iconTheme: const IconThemeData(color: primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: _textColor,
      iconColor: _textColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(
          width: 0.5,
          color: _textColor,
        ),
      ),
      labelStyle: TextStyle(color: _textColor, fontSize: 13),
      hintStyle: TextStyle(color: _textColor, fontSize: 13),
      alignLabelWithHint: true,
      focusColor: _inputInfoColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          width: 2,
          color: _inputInfoColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: inputErrorColor,
          )),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(width: 2, color: _textColor),
      ),
      disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      surface: const Color(0xFFE95054),
    ),
    textTheme: TextTheme(
      labelLarge: const TextStyle(color: _textColor, fontFamily: 'OpenSans'),
      labelSmall: const TextStyle(
          color: _textColor, fontFamily: 'OpenSans', fontSize: 12),
      displayLarge: TextStyle(
        color: _textColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 36,
      ),
      labelMedium: TextStyle(
        color: _textColor,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 20,
      ),
      displayMedium: TextStyle(
        color: _textColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 27,
      ),
      displaySmall: TextStyle(
        color: _textColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 27,
      ),
      headlineMedium: TextStyle(
        color: _textColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 27,
      ),
      headlineSmall: TextStyle(
        color: _textColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 27,
      ),
      titleLarge: TextStyle(
        color: _textColor,
        fontSize: 18,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleMedium: TextStyle(
        color: _textColor,
        fontSize: 16,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleSmall: TextStyle(
        color: _textColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      bodyLarge: TextStyle(
        color: _textColor,
        fontSize: 20,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      bodyMedium: TextStyle(
        color: _textColor,
        fontSize: 12,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Color(0xfff0f0f0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 10,
      focusColor: primaryColor,
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light),
    dividerColor: primaryColor,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          iconColor: MaterialStateProperty.all(Colors.white)),
    ),
    listTileTheme: const ListTileThemeData(
      selectedColor: secondaryColor,
      iconColor: Colors.white,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
  );
}
