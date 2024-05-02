import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

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
              ElevatedButton(onPressed: () => {
                Navigator.popAndPushNamed(context, '/home')
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
