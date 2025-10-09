import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingShortcut extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final String route;

  const BookingShortcut({super.key, 
    required this.icon,
    required this.label,
    required this.description,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.shade100),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurple,
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                SizedBox(height: 4),
                Text(description,
                    style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
