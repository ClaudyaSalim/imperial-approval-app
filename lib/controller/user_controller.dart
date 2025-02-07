import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:imperial_approval_app/firebase_options.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';
import 'package:imperial_approval_app/model/user_class.dart' as app_user;
import 'package:path/path.dart';

class UserController{

  FirebaseFirestore? db;

  Future initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
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

  Future <app_user.User?> getUserByID(userID) async {
    db = FirebaseFirestore.instance;
    app_user.User? user;
    await db!.collection("users").where("id", isEqualTo: userID).get().then((event){
      user = app_user.User.fromJson(event.docs.first.data());
    });

    return user;
  }

  Future <app_user.User?> getCurrUserData() async {
    var auth = FirebaseAuth.instance; // check if localhost is running
    // auth.useAuthEmulator('localhost', 9099);
    auth.userChanges();
    User currUser= auth.currentUser!;
    app_user.User? user;
    await db!.collection("users").where("id", isEqualTo: currUser.uid).get().then((event){
      user = app_user.User.fromJson(event.docs.first.data());
    });

    print("Current user: ${user!.id}");

    return user;
  }

}