import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TrainBookingPage extends StatelessWidget {
  TrainBookingPage({super.key});

  void _launchRailwaySite() async {
    final url = Uri.parse("https://railapp.railway.gov.bd/splash/select-language");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  final List<String> trainImages = [
    'assets/images/train1.jpg',
    'assets/images/train2.jpg',
    'assets/images/train3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Booking"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // 🎠 Slider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
              items: trainImages.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                );
              }).toList(),
            ),
          ),

          // 📝 Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Find train schedules, routes, and book your ticket from the official Bangladesh Railway site.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.6),
            ),
          ),

          SizedBox(height: 25),

          // 🔘 Attractive Button
          GestureDetector(
            onTap: _launchRailwaySite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.greenAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withAlpha((0.4 * 255).toInt()),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.train, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Go to Bangladesh Railway",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
