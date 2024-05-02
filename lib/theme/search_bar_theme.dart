import 'package:flutter/material.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';

SearchBarThemeData searchBarTheme = SearchBarThemeData(
  backgroundColor: MaterialStatePropertyAll(colorScheme.tertiaryContainer),
  elevation: const MaterialStatePropertyAll(5.0),
  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
  // side: MaterialStatePropertyAll(BorderSide(color: colorScheme.primary, width: 2))
);

SearchViewThemeData searchDropDownTheme = SearchViewThemeData(
  surfaceTintColor: colorScheme.primary,
  backgroundColor: colorScheme.onPrimary,
  dividerColor: Colors.transparent,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide.none),
  constraints: const BoxConstraints(maxHeight: 160)
);