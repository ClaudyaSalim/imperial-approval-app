import 'package:flutter/material.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';

SearchBarThemeData searchBarTheme = SearchBarThemeData(
  backgroundColor: MaterialStatePropertyAll(colorScheme.tertiaryContainer),
  surfaceTintColor: MaterialStatePropertyAll(colorScheme.tertiaryContainer),
  elevation: const MaterialStatePropertyAll(0),
  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
  side: MaterialStatePropertyAll(BorderSide(color: colorScheme.tertiary, width: 1)),
  
);

SearchViewThemeData searchDropDownTheme = SearchViewThemeData(
  surfaceTintColor: colorScheme.tertiaryContainer,
  backgroundColor: colorScheme.tertiaryContainer,
  dividerColor: Colors.transparent,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), 
    // side: BorderSide(color: colorScheme.primary, width: 2)
  ),
  // elevation: 1,
  constraints: const BoxConstraints(maxHeight: 160)
);