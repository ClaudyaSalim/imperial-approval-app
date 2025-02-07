import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';
import 'package:imperial_approval_app/model/user_class.dart';

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

    await db!.collection("request type").where("div", isEqualTo: user!.div).get().then((event){
      for (var doc in event.docs) {
        print(doc.data());
        RequestType requestType = RequestType.fromJson(doc.data());
        requestTypeList.add(requestType);
      }
    });

    return requestTypeList;
  }
  
}