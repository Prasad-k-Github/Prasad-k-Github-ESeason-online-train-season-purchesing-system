class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final UserData? user;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }
}

class UserData {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String? address;
  final String? nameWithInitials;
  final String? fromStation;
  final String? toStation;
  final String? travelDate;

  UserData({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    this.address,
    this.nameWithInitials,
    this.fromStation,
    this.toStation,
    this.travelDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      phone: json['phone_number'] ?? json['phone'],
      address: json['address'],
      nameWithInitials: json['name_with_initials'],
      fromStation: json['from_station'],
      toStation: json['to_station'],
      travelDate: json['travel_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'address': address,
      'name_with_initials': nameWithInitials,
      'from_station': fromStation,
      'to_station': toStation,
      'travel_date': travelDate,
    };
  }
}
