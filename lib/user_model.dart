class Users {
  int? id;
  String? name;
  String? login;
  String? email;

  Users({this.id, this.name, this.login, this.email});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['login'] = login;
    data['email'] = email;
    return data;
  }
}
