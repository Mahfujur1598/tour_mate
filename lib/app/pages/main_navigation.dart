import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';

// Pages
import 'home/home_page.dart';
import 'tours/all_tours_page.dart';
import 'tours/my_tours_page.dart';
import 'profile/profile_page.dart';
import '../routes/app_routes.dart';
import '../pages/chatbot/chatbot_page.dart'; // ChatbotPage import

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller
    final nav = Get.put(MainNavigationController(), permanent: true);

    // Pages list
    final pages = [
      const HomePage(),
      const AllToursPage(),
      const MyToursPage(),
      const ProfilePage(),
    ];

    return Obx(
          () => Scaffold(
        body: pages[nav.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: nav.selectedIndex.value,
          onTap: (index) => nav.selectedIndex.value = index,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: "All Tours"),
            BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: "My Tours"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),

        // Global FAB
            floatingActionButton: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.chatbot),
              child: Container(
                width: 50,  // compact & user-friendly
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2196F3), // Dark Blue
                      Color(0xFF64B5F6), // Light Blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 24, // slightly smaller for compact FAB
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
    );
  }
}
