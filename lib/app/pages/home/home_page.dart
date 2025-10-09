import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/main_navigation_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;
  late final AuthController authController;

  final List<String> sliderImages = [
    "assets/images/coxsbazar.jpg",
    "assets/images/sajek.jpg",
    "assets/images/sundarbans.jpg",
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController(), permanent: true);
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TourMate"),
        actions: [
          Obx(() {
            if (authController.isLoggedIn) {
              return GestureDetector(
                onTap: () => Get.toNamed('/profile'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      authController.user.value?['name']?[0] ?? "U",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            } else {
              return TextButton(
                onPressed: () => Get.toNamed('/login'),
                child: const Text("Login"),
              );
            }
          }),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.tour),
              title: const Text("All Tours"),
              onTap: () {
                final nav = Get.find<MainNavigationController>();
                nav.selectedIndex.value = 1;
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("My Tours"),
              onTap: () => Get.toNamed('/my-tours'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),
            const Divider(),
            Obx(() {
              if (authController.isLoggedIn) {
                return ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    authController.logout();
                    Get.back();
                    Get.snackbar("Logged Out", "You have been logged out");
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    hintText: 'Search tours...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(14),
                  ),
                ),
              ),
            ),

            // 🖼️ Carousel Slider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
                items: sliderImages.map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),
            ),

            // 🌟 Popular Tours
            const _SectionTitle('Popular Tours'),
            Obx(() {
              final tours = controller.filteredTours.take(3).toList();
              if (tours.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No tours found"),
                  ),
                );
              }
              return Column(
                children: [
                  ...tours.map((tour) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            tour['image'] as String,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          tour['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          tour['description'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          "${tour['price']}৳",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        onTap: () {
                          if (authController.isLoggedIn) {
                            Get.toNamed('/tour-detail', arguments: tour);
                          } else {
                            Get.snackbar(
                              'Login Required',
                              'Please login to view tour details',
                            );
                            Get.toNamed('/login');
                          }
                        },
                      ),
                    );
                  }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        final nav = Get.find<MainNavigationController>();
                        nav.selectedIndex.value = 1;
                      },
                      child: const Text("See All →"),
                    ),
                  ),
                ],
              );
            }),

            // 🚍 Booking Options
            const _SectionTitle('Bookings'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _buildBookingCard(
                    icon: Icons.directions_bus,
                    title: 'Bus Booking',
                    subtitle: 'Explore intercity travel',
                    route: '/bus-booking',
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(height: 10),
                  _buildBookingCard(
                    icon: Icons.train,
                    title: 'Train Booking',
                    subtitle: 'Book trains with schedule info',
                    route: '/train-booking',
                    color: Colors.lightBlueAccent,
                  ),
                  const SizedBox(height: 10),
                  _buildBookingCard(
                    icon: Icons.hotel,
                    title: 'Hotel Booking',
                    subtitle: 'Find affordable stays & resorts',
                    route: '/hotel-booking',
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        if (authController.isLoggedIn) {
          Get.toNamed(route);
        } else {
          Get.snackbar('Login Required', 'Please login to continue');
          Get.toNamed('/login');
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withAlpha((0.6 * 255).toInt()),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
