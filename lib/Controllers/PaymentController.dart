import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Form input controllers
  final cardNumber = TextEditingController();
  final expirationDate = TextEditingController();
  final cvv = TextEditingController();

  // Method to process the payment
  void processPayment() {
    // Add your payment processing logic here
    String cardNum = cardNumber.text;
    String expDate = expirationDate.text;
    String cvvCode = cvv.text;

    if (_validateInputs()) {
      // Proceed with payment
      Get.snackbar("Payment Successful", "Your payment has been processed.");
    } else {
      Get.snackbar("Payment Failed", "Please check your payment details.");
    }
  }

  // Method to validate inputs
  bool _validateInputs() {
    if (cardNumber.text.isEmpty || expirationDate.text.isEmpty || cvv.text.isEmpty) {
      return false;
    }

    // Add additional validation checks if necessary (e.g., valid card number format, expiration date)
    return true;
  }

  @override
  void onClose() {
    // Dispose controllers when done
    cardNumber.dispose();
    expirationDate.dispose();
    cvv.dispose();
    super.onClose();
  }
}
