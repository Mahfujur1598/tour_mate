import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HotelBookingPage extends StatelessWidget {
   HotelBookingPage({super.key});

  void _launchHotelSite() async {
    final url = Uri.parse("https://bdtickets.com/hotel");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  final List<String> hotelImages = [
    'assets/images/hotel1.jpg',
    'assets/images/hotel2.jpg',
    'assets/images/resort1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel & Resort Booking"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          // 🎠 Hotel Slider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
              items: hotelImages.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                );
              }).toList(),
            ),
          ),

          // 📝 Info Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Find and book hotels or resorts at your destination. Search for affordable stays, user ratings, and more through BDTickets.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.6),
            ),
          ),

          SizedBox(height: 25),

          // 🔘 Go to Booking Button
          GestureDetector(
            onTap: _launchHotelSite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withAlpha((.4 * 255).toInt()),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.hotel, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Go to BDTickets",
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
