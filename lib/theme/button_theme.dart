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