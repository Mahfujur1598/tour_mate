import 'package:get/get.dart';

// Pages
import '../pages/auth/login_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/welcome/welcome_page.dart';
import '../pages/main_navigation.dart';
import '../pages/profile/profile_page.dart';
import '../pages/chatbot/chatbot_page.dart'; // Chatbot page import

// Booking pages
import '../pages/booking/bus_booking_page.dart';
import '../pages/booking/train_booking_page.dart';
import '../pages/booking/hotel_booking_page.dart';
import '../pages/booking/tour_booking_form_page.dart';
import '../pages/booking/booking_confirmation_page.dart';

// Tour
import '../pages/tour_detail/tour_detail_page.dart';

class AppRoutes {
  // Route names
  static const String welcome = '/';
  static const String home = '/home'; // Main navigation
  static const String profile = '/profile';
  static const String chatbot = '/chatbot'; // Chatbot route

  // Booking
  static const String busBooking = '/bus-booking';
  static const String trainBooking = '/train-booking';
  static const String hotelBooking = '/hotel-booking';
  static const String tourBooking = '/tour-book';
  static const String bookingConfirm = '/booking-confirm';

  // Tour
  static const String tourDetail = '/tour-detail';

  // Auth
  static const String login = '/login';
  static const String signup = '/signup';

  // All routes
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    // Core pages
    GetPage(name: welcome, page: () => WelcomePage()),
    GetPage(name: home, page: () => MainNavigation()),
    GetPage(name: profile, page: () => ProfilePage()),
    GetPage(name: chatbot, page: () => ChatBotPage()), // Chatbot route

    // Booking pages
    GetPage(name: busBooking, page: () => BusBookingPage()),
    GetPage(name: trainBooking, page: () => TrainBookingPage()),
    GetPage(name: hotelBooking, page: () => HotelBookingPage()),
    GetPage(name: tourBooking, page: () => TourBookingFormPage()),
    GetPage(name: bookingConfirm, page: () => BookingConfirmationPage()),

    // Tour pages
    GetPage(name: tourDetail, page: () => TourDetailPage()),

    // Auth pages
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: signup, page: () => SignupPage()),
  ];
}
