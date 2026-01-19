import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  final user = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = false.obs;

  // 🔹 My Tours list
  final RxList<Map<String, dynamic>> myTours = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen(_setUser);
  }

  void _setUser(User? firebaseUser) async {
    if (firebaseUser == null) {
      print("User logged out");
      _isLoggedIn.value = false;
      user.value = null;
      myTours.clear();
    } else {
      print("User logged in: ${firebaseUser.uid}");
      _isLoggedIn.value = true;
      final doc = await _firestore.collection("users").doc(firebaseUser.uid).get();
      user.value = {
        "id": firebaseUser.uid,
        "name": doc["name"] ?? "",
        "email": firebaseUser.email,
      };
      await loadMyTours();
    }
  }

  // 🔹 Signup
  Future<void> signup(String name, String email, String password) async {
    try {
      isLoading.value = true;
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(cred.user!.uid).set({
        "name": name,
        "email": email,
      });

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar("Error", "Signup failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Login
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset link sent to $email");
    } catch (e) {
      Get.snackbar("Error", "Reset failed: $e");
    }
  }

  // 🔹 Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      _isLoggedIn.value = false;
      user.value = null;
      myTours.clear();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar("Error", "Logout failed: $e");
    }
  }

  // 🔹 Load my tours from Firestore → bookings
  Future<void> loadMyTours() async {
    print("Loading my tours...");
    if (_auth.currentUser == null) {
      print("No current user!");
      return;
    }

    print("Current user ID: ${_auth.currentUser!.uid}");

    try {
      final snapshot = await _firestore
          .collection("bookings")
          .where("userId", isEqualTo: _auth.currentUser!.uid)
      //.orderBy("timestamp", descending: true) // comment temporarily if timestamp missing
          .get();

      print("Snapshot size: ${snapshot.docs.length}");

      myTours.value = snapshot.docs.map((doc) {
        final data = doc.data();
        print("Booking doc: $data");
        return {
          "id": doc.id,
          "tourName": data["tourName"] ?? "Unknown Tour",
          "price": data["price"] ?? 0,
          "date": data["date"] ?? "",
          "travelerName": data["travelerName"] ?? "",
          "phone": data["phone"] ?? "",
          "guests": data["guests"] ?? 1,
        };
      }).toList();
    } catch (e) {
      print("Error loading my tours: $e");
      Get.snackbar("Error", "Failed to load your bookings: $e");
    }
  }

  // 🔹 Book a tour
  Future<void> bookTour({
    required String tourName,
    required int price,
    required String travelerName,
    required String phone,
    required String date,
    required int guests,
  }) async {
    if (_auth.currentUser == null) {
      print("Cannot book tour, user not logged in");
      return;
    }

    try {
      await _firestore.collection("bookings").add({
        "userId": _auth.currentUser!.uid,
        "tourName": tourName,
        "travelerName": travelerName,
        "phone": phone,
        "date": date,
        "guests": guests,
        "price": price,
        "timestamp": FieldValue.serverTimestamp(),
      });

      print("Booking added successfully");
      await loadMyTours();
      Get.snackbar("Success", "Tour booked successfully!");
    } catch (e) {
      print("Error booking tour: $e");
      Get.snackbar("Error", "Failed to book tour: $e");
    }
  }
}
