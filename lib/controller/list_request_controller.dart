import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';

class ListRequestController {
  FirebaseFirestore? db;
  UserController userController = UserController();
  
  Future <List<Request>> getRequests() async{
    var currUser = await userController.getCurrUserData();
    String userId = currUser!.id!;
    print("User ID in get requests: $userId");
    db = FirebaseFirestore.instance;
    List<Request>userRequests = [];
    await db!.collection("requests").where("user id", isEqualTo: userId).where("status", isEqualTo: "Pending").get().then((event) async {
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


  Future <List<Request>> getAllRequests() async{
    db = FirebaseFirestore.instance;
    List<Request>requests = [];
    await db!.collection("requests").get().then((event) async {
      for(var doc in event.docs){
        print(doc.data());
        Request request = Request.fromJson(doc.data());
        requests.add(request);
      }
    },
    onError: (e) {
      print("Error: $e");
    });
    return requests;
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


  Future<List<Request>> getHistory() async{
    var currUser = await userController.getCurrUserData();
    String userId = currUser!.id!;
    db = FirebaseFirestore.instance;
    List<Request>userHistory = [];
    await db!.collection("requests").where("user id", isEqualTo: userId)
    .where("status", isNotEqualTo: "Pending")
    .get().then((event) async {
      for(var doc in event.docs){
        print(doc.data());
        Request request = Request.fromJson(doc.data());
        RequestType? requestType = await getRequestTypeByID(doc.data()['request type'] as String);
        request.requestType = requestType!;
        userHistory.add(request);
      }
    },
    onError: (e) {
      print("Error: $e");
    });
    return userHistory;
  }
}