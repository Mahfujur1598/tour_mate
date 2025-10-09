import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import 'home/home_page.dart';
import 'tours/all_tours_page.dart';
import 'tours/my_tours_page.dart';
import 'profile/profile_page.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.put(MainNavigationController(), permanent: true);

    final pages = [
      const HomePage(),
      const AllToursPage(),
      const MyToursPage(),
      const ProfilePage(),
    ];

    return Obx(() => Scaffold(
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
    ));
  }
}
