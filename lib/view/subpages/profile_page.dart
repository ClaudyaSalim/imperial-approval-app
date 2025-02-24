import 'package:flutter/material.dart';
import 'package:imperial_approval_app/components/change_pass_dialog.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

import '../../controller/user_controller.dart';
import '../../model/user_class.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController controllerUser = UserController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controllerUser.getCurrUserData(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError){
          return Text("Error");
        }
        else if(!snapshot.hasData){
          return Text("Profile not found");
        }
        User currUser = snapshot.data!;
        
        return Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person_rounded),),
            SizedBox(height: 50,),
            Row(children: [Text("Name:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text(currUser.name!)],),
            Row(children: [Text("Email:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text(currUser.email)],),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Division:", style: textTheme.bodyMedium,), SizedBox(width: 16,), currUser.div is List? Expanded(child: Wrap(children: currUser.div.map<Widget>((data)=> (currUser.div.indexOf(data)==currUser.div.length-1)? Text("$data") : Text("$data, ")).toList())) 
            : Text(currUser.div)],),
            Row(children: [Text("Position:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text(currUser.position)],),
            SizedBox(height: 50,),
            TextButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => ChangePassDialog());
              }, 
              child: Text("Change Password")),
            SizedBox(height: 20,),
            TextButton(
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }, 
              child: Text("Logout", style: TextStyle(color: colorScheme.error)),)
          ],
        );
      }
    );
  }
}