import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imperial_approval_app/controller/list_request_controller.dart';
import 'package:imperial_approval_app/controller/user_controller.dart';
import 'package:imperial_approval_app/model/request_class.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';
import 'package:imperial_approval_app/model/user_class.dart';

class ApprovalController {

  FirebaseFirestore? db;
  UserController userController = UserController();
  ListRequestController requestController = ListRequestController();

  Future<List<Request>>getApprovalList() async {
    User? currUser = await userController.getCurrUserData();
    List<Request>approvalList = [];
    db = FirebaseFirestore.instance;
    Map<String, dynamic> approveFilter = {"comment": "", "date":null, "pass": "pending", "user id": currUser!.id};
    await db!.collection("requests").where("status", isEqualTo: "Pending").where("approvals", arrayContains: approveFilter).get().then((event) async{
      for (var doc in event.docs) {
        // print("filter json: $approveFilter");
        // var dataDoc = doc.data()['approvals'][0] as  Map<String, dynamic>;
        // print("json: ${dataDoc}");
        // print(approveFilter==dataDoc);
        print(doc.data());
        Request request = Request.fromJson(doc.data());
        RequestType? requestType = await requestController.getRequestTypeByID(doc.data()['request type'] as String);
        request.requestType = requestType!;
        approvalList.add(request);
      }
    });
    for (var element in approvalList) {
      print(element.requestType.name);
    }
    return approvalList;
  }


  Future<String?> approve(Request request) async{
    db = FirebaseFirestore.instance;
    String? errorMessage;
    User? approver = await userController.getCurrUserData();
    String approverId = approver!.id!;
    for (var i = 0; i < request.approvals!.length; i++) {
      if(request.approvals![i].approverId == approverId){
        request.approvals![i].date = Timestamp.now();
        request.approvals![i].pass = "approved";
      }
    }
    List<Map<String, dynamic>> approvalData = request.approvals!.map((Approvals data) => data.toJson()).toList();
    await db!.collection("requests").doc("${request.id}").update({"approvals": approvalData}).onError((error, _) => errorMessage = '$error');

    if(errorMessage!=null){return errorMessage;}

    errorMessage = await setDone(request);
    
    return errorMessage;
  }

  Future<String?> reject(Request request, String comment) async {
    db = FirebaseFirestore.instance;
    String? errorMessage;
    User? approver = await userController.getCurrUserData();
    String approverId = approver!.id!;
    for (var i = 0; i < request.approvals!.length; i++) {
      if(request.approvals![i].approverId == approverId){
        request.approvals![i].comment = comment;
        request.approvals![i].date = Timestamp.now();
        request.approvals![i].pass = "rejected";
      }
    }
    List<Map<String, dynamic>> approvalData = request.approvals!.map((data) => data.toJson()).toList();
    await db!.collection("requests").doc("${request.id}").update({"status": "Ditolak", "approvals" : approvalData}).onError((error, _) => errorMessage = '$error');

    return errorMessage;
  }


  Future<String?>setDone(Request request) async {
    db = FirebaseFirestore.instance;
    String? errorMessage;
    int count = 0;
    for (var approval in request.approvals!) {
      if(approval.pass=="approved"){
        count++;
      }
    }
    if (count == request.approvals!.length){
      await db!.collection("requests").doc("${request.id}").update({"status": "Diterima"}).onError((error, _) => errorMessage = '$error');
    }
    return errorMessage;
  }
}