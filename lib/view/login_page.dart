import 'package:flutter/material.dart';
import 'package:imperial_approval_app/database/database.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  DBHelper db = DBHelper();
  final loginFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    // final ThemeData theme = Theme.of(context);
    // final TextTheme textTheme = theme.textTheme;
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imperial-group-logo.png",),
              SizedBox(height: 50,),
              Text(
                'Selamat Datang',
                style: textTheme.displayLarge,
              ),
              SizedBox(height: 50,),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email Karyawan",
                        hintText: "Masukkan ID Karyawan",
                      ) ,
                    ),
                    SizedBox(height: 50,),
                    TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                        labelText: "Password Karyawan",
                        hintText: "Masukkan password",
                      ) ,
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: () async {
                      await db.initFirebase();
                      // await db.getUsers();
                      Map loginDetails = await db.authetication(emailController.value.text, passController.value.text); 
                      // User? currUser = await db.authetication(emailController.value.text, passController.value.text);
                      User? currUser = loginDetails.values.first;
                      String error = loginDetails.keys.first;
                      print("Curr user: ");
                      print(currUser);
                      if(currUser != null){
                        Navigator.popAndPushNamed(context, '/app');
                      }
                      else {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(title: Text('Login Failed'), content: Text(error), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Retry"))],);
                        });
                      }
                    },
                      child: Text("Masuk"),
                    ), // nanti pake OTP atau verifikasi email kalo baru pertama kali login
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
