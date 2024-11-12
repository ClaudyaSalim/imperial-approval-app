import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imperial_approval_app/model/request_type_class.dart';

class Request {

  String? id;
  String? draftId;
  late RequestType requestType;
  late String requestor;
  int? price;
  String? description;
  List<Approvals>? approvals;
  String? status;
  Timestamp? dateRequested;
  DateTime? dateChanged;
  // Request? prevRequest;

  Request({required this.requestType, this.approvals, this.status, this.dateRequested});

  Request.fromJson(Map<String, dynamic> map) {
    id = map['id'] as String;
    draftId = map['draft id'] as String?;
    requestor = map['user id'] as String;
    price = map['price'] as int;
    description = map['description'] as String;
    approvals = (map['approvals'] as List).map((e) => Approvals.fromJson(e as Map<String, dynamic>)).toList();
    status = map['status'] as String;
    dateRequested = map['date_created'] as Timestamp;
  }
}


class Approvals {
  String? approverId;
  Object? date;
  String? comment;
  String? pass;

  // Approvals({required this.userId});
  Approvals.fromJson(Map<String, dynamic> map) {
    approverId = map['user id'] as String?;
    date = map['date']!= null ? map['date'] as Timestamp : null;
    comment = map['comment'] as String?;
    pass = map['pass'] as String?;
  }

}