import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khedme/Models/User.dart'; // Replace with your actual project name
import 'package:khedme/Core/Network/DioClient.dart'; // Make sure DioClient is imported

class RegisterController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void register() async {
    // Create a User object
    User user = User(
      name: name.value.text,
      email: email.value.text,
      phone: phone.value.text,
      password: password.value.text,
    );

    // Convert the User object to JSON
    Map<String, dynamic> request_body = user.toJson();

    // Send the POST request using Dio
    try {
      var post = await DioClient().getInstance().post('/register', data: request_body);
      
      // Check if the response is successful
      if (post.statusCode == 200) {
        print(post.data);
      } else {
        print('Registration failed: ${post.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
