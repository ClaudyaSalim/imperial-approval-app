import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imperial_approval_app/model/request_class.dart';

class CreateRequestController {
  FirebaseFirestore? db;
  
  Future<Request?>createRequest() async{
    Request? newRequest;
    db = FirebaseFirestore.instance;
    
    return newRequest;
  }
  
}