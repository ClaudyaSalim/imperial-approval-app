import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:intl/intl.dart';

class CreateRequestController {
  FirebaseFirestore? db;
  
  Future<Request?>createRequest() async{
    Request? newRequest;
    db = FirebaseFirestore.instance;
    String newId = "R00";
    var data = {
      "company": "ABI",
      // add more
    };
    await db!.collection("requests").doc(newId).set(data);
    
    return newRequest;
  }

  Future <List<RequestType>> getRequestTypeByUser () async {
    List<RequestType> requestTypeList = [];

    db = FirebaseFirestore.instance;
    User? user = await UserController().getCurrUserData();

    await db!.collection("request type").get().then((event){
      for (var doc in event.docs) {
        print(doc.data());
        if(doc.data()['div'].toString().startsWith('[')){
          List divisions = doc.data()['div'];
          for (var div in divisions) {
            if(div == user!.div){
              RequestType requestType = RequestType.fromJson(doc.data());
              requestTypeList.add(requestType);
            }
          }
        }
        else {
          if(doc.data()['div']==user!.div){
            RequestType requestType = RequestType.fromJson(doc.data());
            requestTypeList.add(requestType);
          }
        }
      }
    });

    return requestTypeList;
  }


  Future<String?> sendRequest(requestType, description, price) async{
    String? errorMessage;
    db = FirebaseFirestore.instance;
    User? user = await UserController().getCurrUserData();
    List requests = await ListRequestController().getAllRequests();
    int length = requests.length;

    bool isApprover = false;
    for (var approver in requestType.approvers) {
      if(approver == user!.id){
        isApprover = true;
      }
    }

    if(isApprover){
      requestType.approvers.remove(user!.id);
    }

    var approvals = requestType.approvers.map((approver) => {'comment': '', 'date': null, 'pass': 'pending', 'user id': approver});

    var data = {
      'date_created': FieldValue.serverTimestamp(),
      'description': description,
      'draft id': null,
      'id': 'R0000${length+1}',
      'price': int.parse(price),
      'request type': requestType.id,
      'status': 'Pending',
      'user id': user!.id,
      'approvals': approvals
    };

    db!.collection('requests').doc('R0000${length+1}').set(data).onError((error, _) => errorMessage = '$error');

    return errorMessage;
  }
  
}