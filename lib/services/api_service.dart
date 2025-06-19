import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_season/models/auth_models.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:8080/api/v1';

  // Login function
  static Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/passenger/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        // Handle error responses
        final errorData = jsonDecode(response.body);
        return LoginResponse(
          success: false,
          message: errorData['message'] ?? 'Login failed',
          token: null,
          user: null,
        );
      }
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'Connection error: ${e.toString()}',
        token: null,
        user: null,
      );
    }
  }

  // Registration function
  static Future<LoginResponse> register({
    required String nameWithInitials,
    required String fullName,
    required String address,
    required String phoneNumber,
    required String email,
    required String fromStation,
    required String toStation,
    required String travelDate,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$_baseUrl/passenger/register');

    try {
      final requestBody = {
        'name_with_initials': nameWithInitials,
        'full_name': fullName,
        'address': address,
        'phone_number': phoneNumber,
        'email': email,
        'from_station': fromStation,
        'to_station': toStation,
        'travel_date': travelDate,
        'password': password,
        'confirm_password': confirmPassword,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        // Handle error responses
        final errorData = jsonDecode(response.body);
        return LoginResponse(
          success: false,
          message: errorData['message'] ?? 'Registration failed',
          token: null,
          user: null,
        );
      }
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'Connection error: ${e.toString()}',
        token: null,
        user: null,
      );
    }
  }
}
