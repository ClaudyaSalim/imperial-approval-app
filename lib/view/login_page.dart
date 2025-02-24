import 'package:flutter/material.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:imperial_approval_app/theme/text_theme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  UserController controllerUser = UserController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool isHidden = true;


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
              Image.asset("./assets/images/imperial-group-logo.png",),
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
                      obscureText: isHidden,
                      decoration: InputDecoration(
                        labelText: "Password Karyawan",
                        hintText: "Masukkan password",
                        suffixIcon: 
                        IconButton(onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        }, icon: Icon(isHidden? Icons.visibility_off : Icons.visibility))
                      ) ,
                      
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: () async {
                      Map loginDetails = await controllerUser.authetication(emailController.value.text, passController.value.text); 
                      User? currUser = loginDetails.values.first;
                      String error = loginDetails.keys.first;
                      print("Curr user: ");
                      print(currUser);
                      if(currUser != null){
                        Navigator.popAndPushNamed(context, '/app', arguments: currUser);
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
