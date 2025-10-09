import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 Profile Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 24, left: 20, right: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF009688), Color(0xFF26A69A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Traveler",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "traveler@example.com",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🌍 Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.home_outlined,
                  text: "Home",
                  onTap: () => Get.offAllNamed(AppRoutes.home),
                ),
                _buildMenuItem(
                  icon: Icons.directions_bus,
                  text: "Bus Booking",
                  onTap: () => Get.toNamed(AppRoutes.busBooking),
                ),
                _buildMenuItem(
                  icon: Icons.train,
                  text: "Train Booking",
                  onTap: () => Get.toNamed(AppRoutes.trainBooking),
                ),
                _buildMenuItem(
                  icon: Icons.hotel,
                  text: "Hotel Booking",
                  onTap: () => Get.toNamed(AppRoutes.hotelBooking),
                ),
                _buildMenuItem(
                  icon: Icons.favorite_border,
                  text: "Wishlist",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  text: "Settings",
                  onTap: () {},
                ),
              ],
            ),
          ),

          // 🚪 Bottom Section
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.help_outline,
                  text: "Help & Support",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  text: "Logout",
                  color: Colors.redAccent,
                  onTap: () {
                    // logout logic later
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: (color ?? Colors.teal).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color ?? Colors.teal),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
