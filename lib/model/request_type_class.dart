class RequestType {
  String? id;
  String? name;
  String? div;
  List<dynamic>? requestorPosition;
  List<dynamic>? approvers;
  String? destination;
  // bool? toFinance;

  RequestType(this.id, this.name, this.div, this.requestorPosition, this.approvers, this.destination);

  RequestType.fromJson(Map<String, dynamic> map){
    id = map['id'] as String;
    name = map['name'] as String;
    div = map['div'] as String;
    requestorPosition = map['requestor position'] as List<dynamic>;
    approvers = map['approvers'] as List<dynamic>;
    destination = map['destination'] as String;
    // toFinance = map['to finance'] as bool;
  }
}