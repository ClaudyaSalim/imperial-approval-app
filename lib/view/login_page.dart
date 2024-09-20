import 'package:flutter/material.dart';
import 'package:imperial_approval_app/database/database.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.db});

  DBHelper db;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    // final ThemeData theme = Theme.of(context);
    // final TextTheme textTheme = theme.textTheme;

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
              TextField(
                decoration: InputDecoration(
                  labelText: "Email Karyawan",
                  hintText: "Masukkan ID Karyawan",
                ) ,
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: () async {
                await widget.db.getUsers();
                // Navigator.popAndPushNamed(context, '/app')
              },
                child: Text("Masuk"),
              ), // nanti pake OTP atau verifikasi email kalo baru pertama kali login
            ],
          ),
        ),
      ),
    );
  }
}
