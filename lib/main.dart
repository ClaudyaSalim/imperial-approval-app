import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imperial_approval_app/draft_request.dart';
import 'package:imperial_approval_app/list_request.dart';
import 'package:imperial_approval_app/menu_class.dart';
import 'package:imperial_approval_app/menu_page.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List <MenuClass> listMenu = [
    MenuClass("List Request", ListRequest()),
    MenuClass("List Draft", DraftRequest())
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    listMenu[0].hasMainButton = FloatingActionButton(onPressed: ()=>{print("Create request")});

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Color.fromRGBO(213, 141, 41, 1),
      // brightness: brightness, 
      primary: Color.fromRGBO(213, 141, 41, 1), 
      onPrimary: Color.fromRGBO(245, 241, 240, 1),  // putih
      primaryContainer: Color.fromRGBO(235, 221, 192, 1), // krem
      secondary: Color.fromRGBO(79, 43, 31, 1),
      tertiary: Color.fromRGBO(75, 92, 107, 1)
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
        iconTheme: IconThemeData(size: 24, color: colorScheme.tertiary, applyTextScaling: true),
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
      home: MyLoginPage(title: 'Login Page'),
      routes: {
        '/login':(context) => MyLoginPage(title: 'Login Page'),
        '/list-request': (context) => MenuPage(),
      },
      // home: const MyLoginPage(title: 'Login Page'),
    );
  }
}