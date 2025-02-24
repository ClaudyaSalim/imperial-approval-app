import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/theme/color_scheme.dart';

class ChangePassDialog extends StatefulWidget {
  const ChangePassDialog({super.key});

  @override
  State<ChangePassDialog> createState() => _ChangePassDialogState();
}

class _ChangePassDialogState extends State<ChangePassDialog> {

  final formKey = GlobalKey<FormState>(debugLabel: "Form Key");
  String oldPass = "";
  String newPass = "";
  bool isHidden = true;
  TextEditingController prevPassControl = TextEditingController();
  TextEditingController newPassControl = TextEditingController();
  TextEditingController confirmPassControl = TextEditingController();
  UserController userController = UserController();
  
  String? validation (field, value){
    if(value==null || value.toString().length < 3){
      return "Field must be more than 3 characters";
    }
    else if(field=="prev"){
      oldPass = value.toString();
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
      scrollable: true,
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
                hintText: "Input previous password",
                suffixIcon: IconButton(onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                }, icon: Icon(isHidden? Icons.visibility_off : Icons.visibility))
              ),
              controller: prevPassControl,
              obscureText: isHidden,
              validator: (value) {
                return validation("prev", value);
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "New Password", 
                hintText: "Input new password",
                suffixIcon: IconButton(onPressed: (){setState(() {
                  isHidden = !isHidden;
                });}, icon: Icon(isHidden? Icons.visibility_off : Icons.visibility))
              ),
              controller: newPassControl,
              obscureText: isHidden,
              validator: (value) {
                return validation("new", value);
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm Password", 
                hintText: "Input new password again",
                errorMaxLines: 3,
                suffixIcon: IconButton(onPressed: (){setState(() {
                  isHidden = !isHidden;
                });}, icon: Icon(isHidden? Icons.visibility_off : Icons.visibility),)
              ),
              controller: confirmPassControl,
              obscureText: isHidden,
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
          child: Text("Clear", style: TextStyle(color: colorScheme.tertiary))),

        SizedBox(width: 20,),

        TextButton(
          onPressed: () async {
            
            String? errorMessage;
            if(formKey.currentState!.validate()){
              bool isValidPass = await userController.checkPassword(oldPass);
              if(!isValidPass){
                showDialog(context: context, builder: (context) => AlertDialog(title: Text("Fail to update password"), content: Text("Field previous password is not same with current password"), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Retry"))],),);
              }
              else {
                errorMessage = await userController.changePassword(newPass);
                  if(errorMessage!=null){
                    showDialog(context: context, builder: (context) => AlertDialog(title: Text("Fail to update password"), content: Text(errorMessage!), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Retry"))],),);
                  }
                  else {
                    Navigator.pop(context);
                    showDialog(context: context, builder: (context) => AlertDialog(title: Text("Update Password successful"), content: Text("New password has been activated"), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],));
                  }
              }
            }
          }, 
          child: Text("Confirm"))
      ],
    );
  }
}