import 'package:flutter/material.dart';
import 'package:imperial_approval_app/menu_page.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final List <MenuClass> listMenu = [
  //   MenuClass("List Request", ListRequest()),
  //   MenuClass("List Draft", DraftRequest())
  // ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // listMenu[0].hasMainButton = FloatingActionButton(onPressed: ()=>{print("Create request")});

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Color.fromRGBO(213, 141, 41, 1),
      // brightness: brightness, 
      primary: Color.fromRGBO(213, 141, 41, 1), 
      onPrimary: Color.fromRGBO(245, 241, 240, 1),  // putih
      primaryContainer: Color.fromRGBO(235, 221, 192, 1), // krem
      secondary: Color.fromRGBO(79, 43, 31, 1),
      tertiary: Color.fromRGBO(75, 92, 107, 1),
      // onSecondary: onSecondary, 
      error: Color.fromRGBO(213, 83, 102, 1), 
      // onError: onError, 
      // background: background, 
      // onBackground: onBackground, 
      // surface: surface, 
      // onSurface: onSurface
    );


    const TextTheme textTheme = TextTheme(
          displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontWeight: FontWeight.bold), // buat appbar
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        );


    return MaterialApp(
      
      title: 'Imperial App Request',
      
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        iconTheme: IconThemeData(size: 24, color: colorScheme.tertiary, applyTextScaling: true),
        textTheme: textTheme,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size.fromHeight(50),
          textStyle: textTheme.displayMedium
        )),
        
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: textTheme.displayMedium,
        ),
        
        searchBarTheme: SearchBarThemeData(
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          elevation: MaterialStatePropertyAll(0),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          side: MaterialStatePropertyAll(BorderSide(color: colorScheme.primary, width: 2))
        ),
        
        searchViewTheme: SearchViewThemeData(
          surfaceTintColor: colorScheme.primary,
          backgroundColor: colorScheme.onPrimary,
          dividerColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          constraints: BoxConstraints(maxHeight: 160)
        ),
        
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primaryContainer,
          elevation: 10.0
        ),
        
        drawerTheme: DrawerThemeData(
          width: 200,
          elevation: 10.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          shadowColor: colorScheme.tertiary,
        ),
        
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          shape: CircleBorder(),
          elevation: 10.0,
          iconSize: 30.0
        )

      ),
      
      home: const LoginPage(),
      
      routes: {
        '/login':(context) => LoginPage(),
        '/home': (context) => MenuPage(),
      },
      // home: const LoginPage(title: 'Login Page'),
    );
  }
}