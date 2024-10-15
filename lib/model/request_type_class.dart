class RequestType {
  String? id;
  String? name;
  String? div;
  List<String>? requestorPosition;
  List<String>? approvers;
  String? destination;
  bool? toFinance;

  RequestType(this.id, this.name, this.div, this.requestorPosition, this.approvers, this.destination, this.toFinance);

  RequestType.fromJson(Map<String, dynamic> map){
    id = map['id'] as String;
    name = map['name'] as String;
    div = map['div'] as String;
    requestorPosition = map['requestor position'] as List<String>;
    approvers = map['approvers'] as List<String>;
    destination = map['destination'] as String;
    toFinance = map['to finance'] as bool;
  }
}