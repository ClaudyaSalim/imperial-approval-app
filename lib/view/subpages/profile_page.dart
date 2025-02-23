import 'package:flutter/material.dart';
import 'package:imperial_approval_app/components/change_pass_dialog.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 50, child: Icon(Icons.person_rounded),),
        SizedBox(height: 50,),
        Row(children: [Text("Name:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text("Username")],),
        Row(children: [Text("Email:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text("example@gmail.com")],),
        Row(children: [Text("Division:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text("X")],),
        Row(children: [Text("Position:", style: textTheme.bodyMedium,), SizedBox(width: 16,), Text("Staff")],),
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
}