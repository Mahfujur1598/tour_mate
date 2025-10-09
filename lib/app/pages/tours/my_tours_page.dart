import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class MyToursPage extends StatefulWidget {
  const MyToursPage({super.key});

  @override
  State<MyToursPage> createState() => _MyToursPageState();
}

class _MyToursPageState extends State<MyToursPage> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // ✅ Page load হওয়ার সাথে সাথে Firestore থেকে ডেটা লোড হবে
    authController.loadMyTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tours"),
      ),
      body: Obx(() {
        if (!authController.isLoggedIn) {
          return const Center(
            child: Text("Please login to see your tours"),
          );
        }

        final myTours = authController.myTours;
        if (myTours.isEmpty) {
          return const Center(
            child: Text("You have no booked tours yet"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: myTours.length,
          itemBuilder: (context, index) {
            final tour = myTours[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.card_travel, color: Colors.teal),
                title: Text(tour['name'] ?? "Unknown Tour"),
                subtitle: Text("Booking ID: ${tour['id'] ?? '--'}"),
                trailing: Text(
                  "${tour['price'] ?? 0}৳",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
