import 'package:flutter/material.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

DialogTheme dialogTheme = DialogTheme(
  backgroundColor: colorScheme.onPrimary,
  surfaceTintColor: colorScheme.primaryContainer,
  titleTextStyle: textTheme.displayLarge!.copyWith(color: Colors.black),
  contentTextStyle: textTheme.bodySmall!.copyWith(color: Colors.black),

  // color: Colors.black;
);