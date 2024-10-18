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

class DBHelper{

  FirebaseFirestore? db;

  Future initFirebase() async {
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


  Future <List<Request>> getRequests(String userId) async{
    print("User ID in get requests: $userId");
    db = FirebaseFirestore.instance;
    List<Request>userRequests = [];
    await db!.collection("requests").where("user id", isEqualTo: userId).get().then((event) async {
        for(var doc in event.docs){
          print(doc.data());
          Request request = Request.fromJson(doc.data());
          RequestType? requestType = await getRequestTypeByID(doc.data()['request type'] as String);
          request.requestType = requestType!;
          userRequests.add(request);
        }
    },
    onError: (e) {
      print("Error: $e");
    });
    return userRequests;
  }


  Future <RequestType?> getRequestTypeByID (requestTypeID) async {
    RequestType? requestType;

    db = FirebaseFirestore.instance;

    await db!.collection("request type").where("id", isEqualTo: requestTypeID).get().then((event){
      requestType = RequestType.fromJson(event.docs.first.data());
    });

    return requestType;
  }


  Future <Request?> getRequestByID(requestID) async {
    db = FirebaseFirestore.instance;
    Request? request;
    await db!.collection("requests").where("id", isEqualTo: requestID).get().then((event){
      request = Request.fromJson(event.docs.first.data());
    });

    return request;
  }

}