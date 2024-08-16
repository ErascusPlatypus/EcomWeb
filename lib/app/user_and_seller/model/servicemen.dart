
// servicemen
import 'dart:convert';

List<ServiceMen> serviceMenAPIFromJson(String str) =>
    List<ServiceMen>.from(json.decode(str).map((x) {
      return ServiceMen.fromMap(x);
    }));

class ServiceMen {
  String id;
  String seller_id;
  String service_id;
  String name;
  String email;
  String phone;
  ServiceMen({
    required this.id,
    required this.seller_id,
    required this.service_id,
    required this.name,
    required this.email,
    required this.phone,
  });

  ServiceMen copyWith({
    String? id,
    String? seller_id,
    String? service_id,
    String? name,
    String? email,
    String? phone,
  }) {
    return ServiceMen(
      id: id ?? this.id,
      seller_id: seller_id ?? this.seller_id,
      service_id: service_id ?? this.service_id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'seller_id': seller_id,
      'service_id': service_id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory ServiceMen.fromMap(Map<String, dynamic> map) {
    return ServiceMen(
      id: map['id'] as String,
      seller_id: map['seller_id'] as String,
      service_id: map['service_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceMen.fromJson(String source) => ServiceMen.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceMen(id: $id, seller_id: $seller_id, service_id: $service_id, name: $name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(covariant ServiceMen other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.seller_id == seller_id &&
      other.service_id == service_id &&
      other.name == name &&
      other.email == email &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      seller_id.hashCode ^
      service_id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode;
  }
}
