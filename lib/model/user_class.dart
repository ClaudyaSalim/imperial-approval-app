class User {
  String? id;
  late String? name;
  late String email;
  late String password;
  late String div;
  late String position;
  late String role;

  User({this.id, required this.name, required this.email, required this.password, required this.div, required this.position, required this.role});

  Map<String, dynamic>toMap(){
    return {
      'name' : name,
      'email' : email,
      'password' : password,
      'div' : div,
      'position' : position,
      'role' : role,
    };
  }

  User.fromJson(Map<String, dynamic> map) { 
    id = map['id'] as String;
    name = map['name'] as String;
    email = map['email'] as String;
    password = map['password'] as String;
    div = map['div'] as String;
    position = map['position'] as String;
    role = map['role'] as String;
  }

  // factory User.fromJson(Map<String, dynamic> map) => User(
  //   id: map['id'] as int,
  //   name: map['name'] as String,
  //   email: map['email'] as String,
  //   password: map['password'] as String,
  //   div: map['div'] as String,
  //   position: map['position'] as String,
  //   role: map['role'] as String);
}