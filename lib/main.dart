import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/firebase_options.dart';
import 'package:imperial_approval_app/model/menu_class.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/theme/alert_dialog_theme.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    String initialRoute = '/login';
    // return FutureBuilder(
    //   future: userController.getCurrUserData(),
    //   builder: (context, snapshot) {        
    //     if(snapshot.data != null){
    //       initialRoute = '/app';
    //     }
        // else if (snapshot.connectionState == ConnectionState.waiting){
        //   return MaterialApp(home: Scaffold(body: Text("Please wait ..."),));
        // }
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
                  floatingActionButtonTheme: floatingBtnTheme,
                  dialogTheme: dialogTheme,
                ),
                debugShowCheckedModeBanner: false,
                initialRoute: initialRoute,
                routes: {
                  '/login':(context) => LoginPage(),
                  '/app': (context) => BasePage(),
                  '/app/draft': (context) => BasePage(activePage: MenuClass("List Draft", DraftRequest(), false),),
                  '/detail-request': (context) => DetailPage(request: ModalRoute.of(context)!.settings.arguments as Request,),
                  '/create-request': (context) => CreatePage(),
                  '/detail-draft': (context) => DetailPage(request: ModalRoute.of(context)!.settings.arguments as Request),
                },
              );
      }
    // );
  // }
}