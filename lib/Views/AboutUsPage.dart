import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large image on top
          SizedBox(
            width: double.infinity, // Make the image take the full width
            child: Image.asset(
              'assets/images/meetus.png', // Path to your image
              fit: BoxFit.contain, // Use BoxFit.contain to show the entire image
              height: 350, // Increase the height to show more of the image
            ),
          ),
          const SizedBox(height: 16), // Space between the image and text
          const Text(
            'Contact Us:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black, // Changed to black for visibility
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Email: info@khedme.com\n'
            'Phone: +961 81 035 230',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black, // Changed to black for visibility
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Meet the Developers:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black, // Changed to black for visibility
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '1. Anthony 1\n'
            '2. Anthony 2\n'
            '3. Eliane\n'
            '4. Samer\n'
            '5. Samia',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black, // Changed to black for visibility
            ),
          ),
        ],
      ),
    );
  }
}
