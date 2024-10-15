import 'package:imperial_approval_app/model/request_type_class.dart';

class Request {

  String? id;
  String? draftId;
  late String? typeId;
  late String requestor;
  int? price;
  String? description;
  List<Map<String, dynamic>?>? approvals;
  String? status;
  DateTime? dateRequested;
  DateTime? dateChanged;
  // Request? prevRequest;

  Request({required this.typeId, this.approvals, this.status, this.dateRequested});

  Request.fromJson(Map<String, dynamic> map) {
    id = map['id'] as String;
    draftId = map['draft id'] as String;
    typeId = map['request type'] as String;
    requestor = map['user id'] as String;
    price = map['price'] as int;
    description = map['description'] as String;
    approvals = map['approvals'] as List<Map<String, dynamic>>;
    status = map['status'] as String;
    dateRequested = map['date_created'] as DateTime;
  }
}