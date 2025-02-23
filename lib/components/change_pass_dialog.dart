import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePassDialog extends StatefulWidget {
  const ChangePassDialog({super.key});

  @override
  State<ChangePassDialog> createState() => _ChangePassDialogState();
}

class _ChangePassDialogState extends State<ChangePassDialog> {

  final formKey = GlobalKey<FormState>(debugLabel: "Form Key");
  late String newPass;
  TextEditingController prevPassControl = TextEditingController();
  TextEditingController newPassControl = TextEditingController();
  
  String? validation (field, value) {
    if(value==null || value.toString().length < 3){
      return "Field must be more than 3 characters";
    }
    else if(field=="prev"){
      print("Checking previous password");
    }
    else if(field=="new"){
      newPass = value.toString();
      print("Checking new password");
    }
    else if(field=="confirm"){
      print("Checking confirmation password");
      if(value.toString()!=newPass){
        return "New password and confirmation password must be the same";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Change Password"),
          SizedBox(width: 50,),
          IconButton(icon: Icon(Icons.close_rounded), iconSize: 30,
            onPressed: (){
              Navigator.pop(context);
            },)
        ],
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // set kolom sesuai ukuran konten
          children: [
            SizedBox(height: 28,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Previous Password", 
                hintText: "Input previous password"),
              controller: prevPassControl,
              validator: (value) {
                return validation("prev", value);
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "New Password", 
                hintText: "Input new password"),
              controller: newPassControl,
              validator: (value) {
                return validation("new", value);
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm Password", 
                hintText: "Input new password again",
                errorMaxLines: 3),
              validator: (value) {
                return validation("confirm", value);
              },
            ),
            SizedBox(height: 28,),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            formKey.currentState!.reset();
          }, 
          child: Text("Clear")),

        SizedBox(width: 20,),

        TextButton(
          onPressed: () {
            if(formKey.currentState!.validate()){
              print("All clear");
              print(prevPassControl.text + " " + newPassControl.text);
              Navigator.pop(context);
            }
          }, 
          child: Text("Confirm"))
      ],
    );
  }
}