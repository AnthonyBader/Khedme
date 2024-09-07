import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khedme/Models/User.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() {
    // Here you would typically check the email and password,
    // maybe make a request to an API to authenticate the user
    print("Email: ${email.text}, Password: ${password.text}");

    User user = User(email: email.value.text, password: password.value.text);
    String request_body = user.toJson();
  }
}
