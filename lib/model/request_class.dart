class Request {

  String? id;
  String? draftid;
  late String type;
  late String requestor;
  int? price;
  String? description;
  List<String>? approvers;
  String? status;
  DateTime? dateRequested;
  DateTime? dateChanged;
  Request? prevRequest;

  Request({required this.type, this.approvers, this.status, this.dateRequested});
}