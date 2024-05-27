import 'package:flutter/material.dart';
import 'package:imperial_approval_app/view/subpages/history_page.dart';
import 'package:imperial_approval_app/view/subpages/draft_request.dart';
import 'package:imperial_approval_app/components/drawer.dart';
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
  List listMenu = [
    MenuClass("List Request", ListRequest()),
    MenuClass("List Draft", DraftRequest()),
    MenuClass("History", HistoryPage()),
    MenuClass("Logout", LoginPage())
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.activePage==null){
      widget.activePage = listMenu[0]; 
    }

    listMenu[0].hasMainButton = FloatingActionButton(onPressed: (){Navigator.pushNamed(context, '/create-request');}, child: Icon(Icons.add_rounded),);

    MenuClass targetPage = widget.activePage!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(targetPage.name,),
      ),
      drawer: CustomDrawer(listMenu: listMenu, activePage: targetPage,),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        // kemungkinan isi fragment disini
        child: targetPage.body,
      ),
      floatingActionButton: targetPage.hasMainButton,
    );
  }
}
