import 'package:flutter/material.dart';

import '../constants/constants.dart';

final customThemeData = ThemeData(
  fontFamily: Constants.fontFamily,
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
      0xFF2188FF,
      <int, Color>{
        50: Color(0xffe3f2ff),
        100: Color(0xffbcdfff),
        200: Color(0xff90ccff),
        300: Color(0xff60b7ff),
        400: Color(0xff3ba7ff),
        500: Color(0xff1897ff),
        600: Color(0xff2189ff),
        700: Color(0xff2476eb),
        800: Color(0xff2664d8),
        900: Color(0xff2643b9),
      },
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: Color(0xFF17192D),
    foregroundColor: Color(0xFFF9FAFB),
  ),
  listTileTheme: const ListTileThemeData(
    dense: true,
    titleTextStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Color(0xFF17192D),
    ),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    childrenPadding: EdgeInsets.only(left: 16.0)
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.resolveWith((_) => true),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      padding: const EdgeInsets.all(24.0),
      backgroundColor: const Color(0xFF2188FF),
      alignment: Alignment.centerLeft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      textStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      foregroundColor: const Color(0xFFFFFFFF),
      iconColor: const Color(0xFFFFFFFF),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color:  Color(0xFFEAEEF2),
    space: 0.0,
  ),
);
