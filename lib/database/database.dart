import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:imperial_approval_app/firebase_options.dart';
import 'package:imperial_approval_app/model/user_class.dart' as app_user;
import 'package:path/path.dart';

class DBHelper{

  FirebaseFirestore? db;

  Future initFirebase() async {

    // check correct or not
    // if(kIsWeb){
    //   const firebaseConfig = FirebaseOptions(apiKey: "AIzaSyAOwIcMyJye7bfVSMAPMlrX7au0Lw_9ce4", appId: "1:454517257295:web:91dda7079ec7fe4f92a63a", messagingSenderId: "454517257295", projectId: "approval-app-60411", authDomain: "approval-app-60411.firebaseapp.com", storageBucket: "approval-app-60411.appspot.com");
    //   await Firebase.initializeApp(options: firebaseConfig);
    // }
    
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }


  Future<List<app_user.User>>getUsers() async {
    List<app_user.User> users = [];
    await db!.collection("users").get().then((event) {
      for(var doc in event.docs){
        print(doc.data());
        app_user.User user = app_user.User.fromJson(doc.data());
        users.add(user);
      }
    });
    print("Length of users: " + users.length.toString());
    return users;
  }


  Future <Map<String, app_user.User?>> authetication(String email, String password) async {
    User? userLogin; String error = 'User not found';
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userLogin =credential.user!;
      print(credential);
      print("success");
      db = FirebaseFirestore.instance;
      List users = await getUsers();
      for (app_user.User user in users) {
        if(user.email==userLogin.email){
          print(user.email);
          return {'success': user};
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (email == '') {
        print('Email must be filled');
        error = 'Email must be filled';
      }else if (e.code == 'missing-password') {
        print('Password must be filled');
        error = 'Password must be filled';
      } else if (e.code == 'user-not-found') {
        print('No user found for that email.');
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        error = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email'){
        print('Email is invalid.');
        error = 'Email is invalid.';
      } else if (e.code == 'invalid-credential'){
        error = 'Your credentials are invalid';
      } else if (e.code == 'user-disabled'){
        print('Your email might have been disabled.');
        error = 'Your email might have been disabled.';
      }
    } catch (e) {
      print(e);
    }
    return {error: null};
  }


}