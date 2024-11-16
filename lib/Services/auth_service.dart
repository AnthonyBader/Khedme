import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';  // Ensure this import is added
import 'api_service.dart';

class AuthService extends ApiService {
  Future<bool> register(String firstName, String lastName, String email, String phone, String address, String password) async {
    final url = buildUrl("/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "password": password,
      }),
    );

    return response.statusCode == 201; // Registration successful
  }

@override
Future<http.Response> login(String email, String password) async {
  final url = buildUrl("/login");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    // Parse the response
    final data = json.decode(response.body);

    // Save user ID to shared preferences
    final prefs = await SharedPreferences.getInstance();
    final userId = data['data']['id']; // Assuming 'id' is in 'data'
    prefs.setString('userId', userId.toString());

    return response; // Return entire response
  } else {
    print("Error logging in: ${response.body}");
    throw Exception("Login failed"); // Throw an exception for failed login
  }
}


  Future<http.Response> logout(String token) async {
    final url = buildUrl("/logout");

    final response = await http.post(
      url,
      headers: getHeaders(token),
    );

    return response;
  }
}


Future<void> checkUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');

  if (userId != null) {
    print("User ID: $userId");  // This will print the saved user ID if it exists
  } else {
    print("User ID not found in shared preferences.");
  }
}
