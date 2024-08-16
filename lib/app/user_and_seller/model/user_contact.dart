import 'dart:convert';

UserContact contactFromJson(String str) => UserContact.fromJson(json.decode(str));

String contactToJson(UserContact data) => json.encode(data.toJson());

class UserContact {
  UserContact({
    this.email,
    this.name,
    this.phone,
  });

  UserContact.fromJson(dynamic json) {
    email = json['email'];
    name = json['name'] != null ? json['name'] : [];
    phone = json['phone'] != null ? json['phone'] : [];
  }

  String? email;
  String? name;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }
}
