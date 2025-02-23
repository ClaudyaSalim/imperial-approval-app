import 'package:flutter/material.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/menu_class.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/view/base_page.dart';
import 'package:imperial_approval_app/view/subpages/notifikasi.dart';
import 'package:imperial_approval_app/view/subpages/profile_page.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key, required this.listMenu, required this.activePage});

  final List listMenu; final MenuClass activePage;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  late MenuClass targetPage;
  late int selectedIndex;
  late List menuList;
  UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    menuList = widget.listMenu;
  }

  int getSelectedIndex(){
    if(targetPage.name=="Notifikasi"){
      return -1;
    }
    else {
      for (int i = 0; i < menuList.length; i++) {
        if(targetPage.name==menuList[i].name){
          return i;
        }
      }
    }
    return -2;
  }

  void setMenuPage(int selectedIndex){
    if(selectedIndex==menuList.length-1){
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      return;
    }
    setState(() {
      if(selectedIndex==-1){
        targetPage = MenuClass("Notifikasi", Notif(), false);
      }
      else if (selectedIndex==-2){
        targetPage = MenuClass("Profile", ProfilePage(), false);
      }
      else {
        targetPage = menuList[selectedIndex];
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BasePage(activePage: targetPage)));
    });
  }

  Widget setDrawerHeader(Color bgColor, Color avatarColor, Color iconColor, Color textColor, snapshot){
    TextStyle textStyle = TextStyle(color: textColor);
    User? currUser = snapshot.data;
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: bgColor),
      currentAccountPicture: (snapshot.connectionState == ConnectionState.waiting || currUser == null)?CircularProgressIndicator() : CircleAvatar(child: Icon(Icons.person, color: iconColor,), backgroundColor: avatarColor,),
      accountName: (snapshot.connectionState == ConnectionState.waiting || currUser == null)? CircularProgressIndicator() : Text(currUser.name!, style: textStyle,), accountEmail: Text(currUser!.email, style: textStyle,),
    );
  }

  @override
  Widget build(BuildContext context) {
    targetPage = widget.activePage;
    selectedIndex = getSelectedIndex();
    return Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FutureBuilder(
                future: userController.getCurrUserData(),
                builder: (context, snapshot) {
                  if(snapshot.data!=null){
                    return ListView(
                      children: [
                        InkWell(
                          child: (selectedIndex==-2)?
                            setDrawerHeader(colorScheme.primary, colorScheme.onPrimary, colorScheme.tertiary, colorScheme.onPrimary, snapshot):
                            setDrawerHeader(Colors.transparent, colorScheme.tertiary, colorScheme.onPrimary, colorScheme.tertiary, snapshot),
                          onTap: () {
                            selectedIndex = -2;
                            setMenuPage(selectedIndex);
                          },
                        ),
                        ListTile(
                          onTap: () {
                            selectedIndex = -1;
                            setMenuPage(selectedIndex);
                          },
                          title: Text("Notification"), 
                          trailing: Icon(Icons.notifications_rounded),
                          selected: (targetPage.name=="Notifikasi")? true:false,
                        ),
                        Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: menuList.length,
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
                                Text(menuList[index].name, 
                                style: (menuList[index].name=='Logout')?TextStyle(color: colorScheme.error):null)
                              ),
                              selected: selected,
                            );
                          }
                        )
                      ],
                    );
                  }
                  else {
                    return LinearProgressIndicator();
                  }
                }
              ),
            ),
            SizedBox(height: 30, child: Text("Versi aplikasi: Ver 1.0"))
          ],
        ),
      );
  }
}