import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingConfirmationPage extends StatelessWidget {
  const BookingConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map? ?? {};
    final tour = (args['tour'] as Map?) ?? {};
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tour['name'] ?? 'Tour', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Traveler: ${args['name']}'),
            Text('Phone: ${args['phone']}'),
            Text('Date: ${(args['date'] as String?)?.split('T').first ?? ''}'),
            Text('Guests: ${args['guests']}'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Get.snackbar('Booked', 'Your booking has been placed');
                Get.back(); // return to form/detail
                Get.back();
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirm Booking'),
            )
          ],
        ),
      ),
    );
  }
}
