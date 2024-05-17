import 'package:flutter/material.dart';
import 'package:imperial_approval_app/view/subpages/draft_request.dart';
import 'package:imperial_approval_app/components/drawer.dart';
import 'package:imperial_approval_app/view/subpages/list_request.dart';
import 'package:imperial_approval_app/model/menu_class.dart';
import 'login_page.dart';

class BasePage extends StatefulWidget {
  BasePage({super.key, required this.activePage});

  final MenuClass activePage;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  // late int selectedIndex;
  List listMenu = [
    MenuClass("List Request", ListRequest()),
    MenuClass("List Draft", DraftRequest()),
    MenuClass("Logout", LoginPage())
  ];

  // @override
  // void initState() {
  //   // super.initState();
  //   // selectedIndex = 0;
  //   widget.activePage = listMenu[0];
  //   bodyPage = widget.activePage;
  // }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);

  //   if(widget.activePage!=listMenu[0]){
  //     bodyPage = widget.activePage;
  //   }
  // }

  // void setBasePage(int selectedIndex){
  //   if(selectedIndex==listMenu.length-1){
  //     Navigator.popAndPushNamed(context, '/login');
  //     return;
  //   }
  //   setState(() {
  //     if(selectedIndex==-1){
  //       activePage = MenuClass("Notifikasi", Notif());
  //     }
  //     else {
  //       activePage = listMenu[selectedIndex];
  //     }
  //     Navigator.pop(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    MenuClass targetPage = widget.activePage;
    
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
