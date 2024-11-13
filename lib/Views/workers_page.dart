import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Models/Worker.dart';
import 'package:khedme/Services/api_service.dart';
import 'package:khedme/Routes/AppRoute.dart';

extension StringExtension on String {
  String get capitalize => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

class WorkersPage extends StatefulWidget {
  final String service;

  const WorkersPage({Key? key, required this.service}) : super(key: key);

  @override
  _WorkersPageState createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  final ApiService apiService = ApiService();
  late Future<List<KhedmeWorker>> _workersFuture;

  @override
  void initState() {
    super.initState();
    _workersFuture = apiService.fetchWorkersByService(widget.service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.service} Workers')),
      body: FutureBuilder<List<KhedmeWorker>>(
        future: _workersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No workers available'));
          } else {
            final workers = snapshot.data!;
            return ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: ListTile(
                    title: Text('${worker.firstName} ${worker.lastName}'),
                    subtitle: Text(
                      'Role: ${worker.role}\nRating: ${worker.rating?.toString() ?? "Not rated"}',
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to the PaymentPage with Get.toNamed, passing the worker as an argument
                        Get.toNamed(AppRoute.payment, arguments: worker);
                      },
                      child: const Text('Book Now'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
