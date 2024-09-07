import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void register() {
    // Here you would typically check the email and password,
    // maybe make a request to an API to register the user
    print("Name: ${name.text}, Phone: ${phone.text}, Email: ${email.text}, Password: ${password.text}");
  }
}