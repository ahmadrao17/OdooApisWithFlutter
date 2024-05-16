class users {
  int? id;
  String? name;
  String? login;
  String? email;

  users({this.id, this.name, this.login, this.email});

  users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['login'] = this.login;
    data['email'] = this.email;
    return data;
  }
}
