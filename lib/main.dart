import 'package:flutter/material.dart';
import 'package:imperial_approval_app/database/database.dart';
import 'package:imperial_approval_app/model/menu_class.dart';
import 'package:imperial_approval_app/view/base_page.dart';
import 'package:imperial_approval_app/theme/appbar_theme.dart';
import 'package:imperial_approval_app/theme/button_theme.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/drawer_theme.dart';
import 'package:imperial_approval_app/theme/search_bar_theme.dart';
import 'package:imperial_approval_app/theme/text_field_theme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:imperial_approval_app/view/create_request_page.dart';
import 'package:imperial_approval_app/view/detail_page.dart';
import 'package:imperial_approval_app/view/subpages/draft_request.dart';
import 'package:imperial_approval_app/view/subpages/list_request.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'view/login_page.dart';

void main() {
  var databaseFactory = databaseFactoryFfi;
  DBHelper db = DBHelper();
  runApp(MyApp(database: db,));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.database});

  DBHelper database;

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
        outlinedButtonTheme: secBtnTheme,
        textButtonTheme: txtBtnTheme,     
        inputDecorationTheme: textFieldTheme,      
        searchBarTheme: searchBarTheme,      
        searchViewTheme: searchDropDownTheme,
        appBarTheme: appBarTheme,
        drawerTheme: drawerTheme,
        floatingActionButtonTheme: floatingBtnTheme
      ),
      initialRoute: '/login',
      routes: {
        '/login':(context) => LoginPage(db: database,),
        '/app': (context) => BasePage(db: database,),
        '/app/draft': (context) => BasePage(activePage: MenuClass("List Draft", DraftRequest()), db: database,),
        '/detail-request': (context) => DetailPage(isDraft: false,),
        '/create-request': (context) => CreatePage(),
        '/detail-draft': (context) => DetailPage(isDraft: true),
      },
    );
  }
}