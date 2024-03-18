import 'package:flutter/material.dart';
import 'package:imperial_approval_app/draft_request.dart';
import 'package:imperial_approval_app/list_request.dart';
import 'package:imperial_approval_app/menu_class.dart';
import 'login_page.dart';
import 'notifikasi.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  late int selectedIndex;
  List listMenu = [
    MenuClass("List Request", ListRequest()),
    MenuClass("List Draft", DraftRequest()),
    MenuClass("Logout", LoginPage())
  ];
  late MenuClass activePage;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    activePage = listMenu[0];
  }

  void setMenuPage(int selectedIndex){
    if(selectedIndex==listMenu.length-1){
      Navigator.popAndPushNamed(context, '/login');
      return;
    }
    setState(() {
      if(selectedIndex==-1){
        activePage = MenuClass("Notifikasi", Notif());
      }
      else {
        activePage = listMenu[selectedIndex];
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    // final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;
    // final TextTheme textTheme = theme.textTheme;

    listMenu[0].hasMainButton = FloatingActionButton(onPressed: null);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(activePage.name),
      ),
      drawer: Drawer(
        width: 200,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text("Test User"), accountEmail: Text("test@email.com")),
            ListTile(
              onTap: () {
                selectedIndex = -1;
                setMenuPage(selectedIndex);
              },
              title: Text("Notification"), 
              trailing: Icon(Icons.notifications_rounded),
              selected: (activePage.name=="Notifikasi")? true:false,
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listMenu.length,
              itemBuilder: (context, index) {
                int menuIndex = index;
                bool selected = false;
                if(menuIndex==selectedIndex){
                  selected = true;
                }
                return ListTile(
                  onTap: () {
                    selectedIndex = menuIndex;
                    setMenuPage(selectedIndex);
                  },
                  title: (
                    Text(listMenu[index].name)
                  ),
                  selected: selected,
                );
              }
            )
          ],
        ),
      ),
      body: Center(
        // kemungkinan isi fragment disini
        child: activePage.body,
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     // list request
        //   ],
        // ),
      ),
      floatingActionButton: activePage.hasMainButton,
      // FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // )
    );
  }
}
