import 'package:flutter/material.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';

SearchBarThemeData searchBarTheme = SearchBarThemeData(
  backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
  elevation: const MaterialStatePropertyAll(0),
  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
  side: MaterialStatePropertyAll(BorderSide(color: colorScheme.primary, width: 2))
);

SearchViewThemeData searchDropDownTheme = SearchViewThemeData(
  surfaceTintColor: colorScheme.primary,
  backgroundColor: colorScheme.onPrimary,
  dividerColor: Colors.transparent,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  constraints: const BoxConstraints(maxHeight: 160)
);