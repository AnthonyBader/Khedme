import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String phoneNumber;
  late String address;
  late String degrees;
  late String cv;
  late String id;
  late String otherInfo;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data from the database
  }

  // Fetch user data from the database
  Future<void> fetchUserData() async {
    // Replace with your actual API endpoint
    final response = await http.get(Uri.parse('https://yourapi.com/user/profile'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        name = data['name'];
        email = data['email'];
        phoneNumber = data['phone_number'];
        address = data['address'];
      });
    } else {
      // Handle error
      showErrorSnackbar('Failed to load user data.');
    }
  }

  // Update user data in the database
  Future<void> updateUserData() async {
    final response = await http.put(
      Uri.parse('https://yourapi.com/user/profile'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'address': address,
        'degrees': degrees,
        'cv': cv,
        'id': id,
        'other_info': otherInfo,
      }),
    );

    if (response.statusCode == 200) {
      // showConfirmationDialog('Details updated successfully!');
    } else {
      showErrorSnackbar('Failed to update details.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile_picture.png'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: () {
                        // Handle image selection
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Display user information
              _buildProfileInfo("Name", name),
              _buildProfileInfo("Email", email),
              _buildProfileInfo("Phone Number", phoneNumber),
              _buildProfileInfo("Address", address),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showUpdateDetailsDialog();
                },
                child: const Text('Change Details'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showApplyToBeWorkerDialog();
                },
                child: const Text('Apply to be a Worker'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build profile information display
  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Show dialog to update user details
  void _showUpdateDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Details'),
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('Email', (value) => email = value!, false, true),
                  _buildTextField('Phone Number', (value) => phoneNumber = value!, false, true),
                  _buildTextField('Address', (value) => address = value!, true),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).pop();
                  updateUserData(); // Call the function to update user data
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for applying to be a worker
  void _showApplyToBeWorkerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apply to be a Worker'),
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('Degrees', (value) => degrees = value!, true),
                  _buildTextField('CV', (value) => cv = value!, true),
                  _buildTextField('ID', (value) => id = value!, true),
                  _buildTextField('Other Information', (value) => otherInfo = value!, true),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).pop();
                  // Handle form submission (e.g., save to database or API)
                  _showConfirmationDialog("Application submitted successfully!");
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, FormFieldSetter<String> onSaved, bool isRequired, [bool isReadOnly = false]) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      onSaved: onSaved,
      readOnly: isReadOnly, // Disable editing for email and phone number
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Show confirmation dialog after submission
  void _showConfirmationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Show error snackbar
  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
