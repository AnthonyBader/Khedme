import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khedme/Models/User.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() {
    // Logging the email and password
    print("Email: ${email.text}, Password: ${password.text}");

    // Create a User object for login
    User user = User(email: email.value.text, password: password.value.text);

    // Convert to JSON for API request
    Map<String, dynamic> request_body = user.toJson();
    
    print(request_body);  // You can see the output in console

    // You can later use DioClient to make an actual API call like this:
    // var response = await DioClient().getInstance().post('/login', data: request_body);
  }
}
