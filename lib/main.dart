import 'package:flutter/material.dart';
import 'package:imperial_approval_app/list_request_page.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Color.fromRGBO(213, 141, 41, 1),
      // brightness: brightness, 
      primary: Color.fromRGBO(213, 141, 41, 1), 
      onPrimary: Color.fromRGBO(245, 241, 240, 1), 
      primaryContainer: Color.fromRGBO(235, 221, 192, 1),
      secondary: Color.fromRGBO(79, 43, 31, 1), 
      // onSecondary: onSecondary, 
      // error: error, 
      // onError: onError, 
      // background: background, 
      // onBackground: onBackground, 
      // surface: surface, 
      // onSurface: onSurface
    );
    return MaterialApp(
      title: 'Imperial App Request',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size.fromHeight(50)
        )),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primaryContainer,
          elevation: 10.0
        )
      ),
      routes: {
        '/':(context) => MyLoginPage(title: 'Login Page'),
        '/list-request': (context) => ListRequestPage(title: 'List Request')
      },
      // home: const MyLoginPage(title: 'Login Page'),
    );
  }
}