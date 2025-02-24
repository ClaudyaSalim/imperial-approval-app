import 'package:flutter/material.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

ElevatedButtonThemeData primaryBtnTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)
    ),
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    minimumSize: const Size.fromHeight(50),
    textStyle: textTheme.displayMedium
  )
);

FloatingActionButtonThemeData floatingBtnTheme = FloatingActionButtonThemeData(
  foregroundColor: colorScheme.onPrimary,
  backgroundColor: colorScheme.primary,
  shape: const CircleBorder(),
  elevation: 10.0,
  iconSize: 30.0
);

OutlinedButtonThemeData secBtnTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: colorScheme.tertiary, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0)
    ),
    minimumSize: const Size.fromHeight(50),
    foregroundColor: colorScheme.tertiary,
    textStyle: textTheme.displayMedium
  )
);

TextButtonThemeData txtBtnTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    minimumSize: Size.zero, // Set this
    padding: EdgeInsets.zero, 
    textStyle: TextStyle(fontWeight: FontWeight.bold)
  )
);