import 'package:flutter/material.dart';
import 'package:imperial_approval_app/menu_page.dart';
import 'package:imperial_approval_app/theme/appbar_theme.dart';
import 'package:imperial_approval_app/theme/button_theme.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/drawer_theme.dart';
import 'package:imperial_approval_app/theme/search_bar_theme.dart';
import 'package:imperial_approval_app/theme/text_field_theme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Imperial App Request',

      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        iconTheme: IconThemeData(size: 24, color: colorScheme.tertiary, applyTextScaling: true),
        textTheme: textTheme,
        elevatedButtonTheme: primaryBtnTheme,      
        inputDecorationTheme: textFieldTheme,      
        searchBarTheme: searchBarTheme,      
        searchViewTheme: searchDropDownTheme,
        appBarTheme: appBarTheme,
        drawerTheme: drawerTheme,
        floatingActionButtonTheme: floatingBtnTheme
      ),
      initialRoute: '/login',
      routes: {
        '/login':(context) => LoginPage(),
        '/home': (context) => MenuPage(),
      },
    );
  }
}