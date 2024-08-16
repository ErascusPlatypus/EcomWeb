class BookingDetails {
  final int id;
  final String user;
  final String seller;
  final String address;
  final String issue;
  final String date;
  final String time;
  final String mechanicPhone;
  final String? servicemanEmail;
  final DateTime? repairTime;
  final int servicemanStatus;
  final String? feedback;

  BookingDetails({
    required this.id,
    required this.user,
    required this.seller,
    required this.address,
    required this.issue,
    required this.date,
    required this.time,
    required this.mechanicPhone,
    required this.servicemanEmail,
    required this.repairTime,
    required this.servicemanStatus,
    required this.feedback,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      id:int.parse(json['id']),
      user: json['user'],
      seller: json['seller'],
      address: json['address'],
      issue: json['issue'],
      date: json['date'],
      time: json['time'],
      mechanicPhone: json['mechanic_phone'],
      servicemanEmail: json['serviceman_email'],
      repairTime: json['repair_time'] != null
          ? DateTime.parse(json['repair_time'])
          : null,
      servicemanStatus: int.parse(json['serviceman_status']),
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'user': user,
      'seller': seller,
      'address': address,
      'issue': issue,
      'date': date,
      'time': time,
      'mechanic_phone': mechanicPhone,
      'serviceman_email': servicemanEmail,
      'repair_time': repairTime != null ? repairTime!.toIso8601String() : null,
      'serviceman_status': servicemanStatus,
      'feedback': feedback,
    };
  }
}
