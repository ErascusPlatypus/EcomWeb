import 'dart:convert';

List<AppointmentsUser> appointmentsUserFromJson(String str) => List<AppointmentsUser>.from(json.decode(str).map((x) => AppointmentsUser.fromJson(x)));

String appointmentsUserToJson(List<AppointmentsUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentsUser {
  AppointmentsUser({
    required this.id,
    required this.user,
    required this.seller,
    required this.service,
    required this.address,
    required this.issue,
    required this.date,
    required this.time,
    required this.mechanicPhone,
    required this.repairTime,
    required this.serviceman_status,
  });

  String id;
  String user;
  String seller;
  String service;
  String address;
  String issue;
  String date;
  String time;
  String repairTime;
  String serviceman_status;
  String mechanicPhone;

  factory AppointmentsUser.fromJson(Map<String, dynamic> json) => AppointmentsUser(
        id: json["id"],
        user: json["user"],
        seller: json["seller"],
        service: json["service"],
        address: json["address"],
        issue: json["issue"],
        date: json["date"],
        time: json["time"],
        mechanicPhone: json["mechanic_phone"],
        repairTime: json['repair_time'] ?? '',
        serviceman_status: json['serviceman_status'] ?? '',
      );

  Map<String, dynamic> toJson() => {"id": id, "user": user, "seller": seller, "service": service, "address": address, "issue": issue, "date": date, "time": time, "mechanic_phone": mechanicPhone};
}
