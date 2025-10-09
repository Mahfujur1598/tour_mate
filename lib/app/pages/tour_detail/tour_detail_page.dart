import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/tour_controller.dart';
import '../../models/tour.dart';
import '../../routes/app_routes.dart';

class TourDetailPage extends StatelessWidget {
  TourDetailPage({super.key});

  final auth = Get.put(AuthController());
  final tourController = Get.put(TourController());

  @override
  Widget build(BuildContext context) {
    // Accept either a Tour, a Map, or an ID
    final args = Get.arguments;
    Tour? tour;
    if (args is Tour) {
      tour = args;
    } else if (args is Map<String, dynamic>) {
      tour = Tour.fromMap(args);
    } else if (args is String) {
      tour = tourController.byId(args);
    }

    if (tour == null) {
      return const Scaffold(body: Center(child: Text('Tour not found')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tour.name),
        actions: [
          Obx(() => IconButton(
                onPressed: () => tourController.toggleFavorite(tour!.id),
                icon: Icon(
                  tourController.isFavorite(tour!.id) ? Icons.favorite : Icons.favorite_border,
                ),
              )),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                tour.imageUrl.isNotEmpty ? tour.imageUrl : 'assets/images/placeholder.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(tour.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on, size: 18),
              const SizedBox(width: 4),
              Text(tour.location),
              const SizedBox(width: 16),
              const Icon(Icons.schedule, size: 18),
              const SizedBox(width: 4),
              Text(tour.duration),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, size: 18),
              const SizedBox(width: 4),
              Text(tour.rating.toStringAsFixed(1)),
              const Spacer(),
              Text('BDT ${tour.price}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          Text(tour.description),
          const SizedBox(height: 24),
          ElevatedButton.icon(
              onPressed: () {
                if (!auth.isLoggedIn) {
                  Get.toNamed(
                    AppRoutes.login,
                    arguments: {'redirect': AppRoutes.tourBooking, 'tourId': tour!.id},
                  );
                  return;
                }
                Get.toNamed(AppRoutes.tourBooking, arguments: tour!.toMap());
              },

            icon: const Icon(Icons.shopping_bag),
            label: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
