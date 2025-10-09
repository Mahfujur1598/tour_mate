import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class AllToursPage extends StatelessWidget {
  const AllToursPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SafeArea(
      child: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                onChanged: controller.updateSearch,
                decoration: const InputDecoration(
                  hintText: 'Search all tours...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
          ),

          // 📋 Tours list
          Expanded(
            child: Obx(() {
              final tours = controller.filteredTours;
              if (tours.isEmpty) {
                return const Center(child: Text("No tours found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: tours.length,
                itemBuilder: (context, index) {
                  final tour = tours[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: tour['image'] != null &&
                            (tour['image'] as String).startsWith("http")
                            ? Image.network(
                          tour['image'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          tour['image'] ?? "assets/images/default.jpg",
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        tour['name'] ?? "Unknown Tour",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        tour['description'] ?? "No description",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        "${tour['price']}৳",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      onTap: () =>
                          Get.toNamed('/tour-detail', arguments: tour),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
