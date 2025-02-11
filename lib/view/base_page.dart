import 'package:flutter/material.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:imperial_approval_app/view/subpages/history_page.dart';
import 'package:imperial_approval_app/view/subpages/draft_request.dart';
import 'package:imperial_approval_app/components/drawer.dart';
import 'package:imperial_approval_app/view/subpages/list_approval.dart';
import 'package:imperial_approval_app/view/subpages/list_request.dart';
import 'package:imperial_approval_app/model/menu_class.dart';
import 'login_page.dart';

class BasePage extends StatefulWidget {
  BasePage({super.key, this.activePage});

  MenuClass? activePage;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  // late int selectedIndex;
  UserController userController = UserController();
  User? currUser;
  List listMenu = [];
  MenuClass? targetPage;

  void initUser() async {
    currUser = await userController.getCurrUserData();
  }

  void initMenu(){
    listMenu.add(MenuClass("List Request", ListRequest()));
    if(currUser!.role=="Approver"){
      listMenu.add(MenuClass("List Approval", ListApproval()));
    }

    listMenu.addAll(
      [MenuClass("List Draft", DraftRequest()),
      MenuClass("History", HistoryPage()),
      MenuClass("Logout", LoginPage())]
    );

    widget.activePage ??= listMenu[0];

    listMenu[0].hasMainButton = FloatingActionButton(onPressed: (){Navigator.pushNamed(context, '/create-request');}, child: Icon(Icons.add_rounded),);

    targetPage = widget.activePage!;
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {

    // User? currUser = ModalRoute.of(context)!.settings.arguments as User?;
    
    return FutureBuilder(
      future: userController.getCurrUserData(),
      builder: (context, snapshot) {
        if(snapshot.data!=null){
          initMenu();
          return Scaffold(
            appBar: AppBar(
              title: Text(targetPage!.name,),
            ),
            drawer: CustomDrawer(listMenu: listMenu, activePage: targetPage!),
            body: Padding(
              padding: EdgeInsets.all(25.0),
              // kemungkinan isi fragment disini
              child: targetPage!.body,
            ),
            floatingActionButton: targetPage!.hasMainButton,
          );
        }
        else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
