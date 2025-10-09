import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BusBookingPage extends StatelessWidget {
   BusBookingPage({super.key});

  final String bookingUrl = 'https://www.bdtickets.com';

  final List<String> sliderImages = [
    'assets/images/bus1.jpg',
    'assets/images/bus2.jpg',
    'assets/images/bus3.jpg',
  ];

  Future<void> _launchBookingSite() async {
    final url = Uri.parse(bookingUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $bookingUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Booking"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.indigo.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 🎠 Bus Slider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                ),
                items: sliderImages.map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                  );
                }).toList(),
              ),
            ),

            // 📝 Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                "Get your bus tickets instantly with trusted services. Safe, secure and hassle-free!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.6, color: Colors.indigo.shade900),
              ),
            ),

            SizedBox(height: 25),

            // 🔘 Button (Similar to TrainBookingPage)
            GestureDetector(
              onTap: _launchBookingSite,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
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
                    Icon(Icons.directions_bus, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Go to BDTickets",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
