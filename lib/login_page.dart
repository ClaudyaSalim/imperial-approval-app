import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

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
                  border: OutlineInputBorder(),
                  labelText: "Email Karyawan",
                  hintText: "Masukkan ID Karyawan"
                ) ,
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: () => {
                Navigator.popAndPushNamed(context, '/list-request')
              },
                child: Text("Masuk", style: textTheme.displayMedium!.copyWith(color: Colors.white)),
                style: theme.elevatedButtonTheme.style
              ), // nanti pake OTP atau verifikasi email kalo baru pertama kali login
            ],
          ),
        ),
      ),
    );
  }
}
