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

  // 🔹 Loading state
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
      _isLoggedIn.value = false;
      user.value = null;
      myTours.clear();
    } else {
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

  // 🔹 Load tours from Firestore
  Future<void> loadMyTours() async {
    if (_auth.currentUser == null) return;

    try {
      final snapshot = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("tours")
          .orderBy("createdAt", descending: true)
          .get();

      myTours.value = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          "name": doc["name"] ?? "Unknown Tour",
          "price": doc["price"] ?? 0,
        };
      }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load tours: $e");
    }
  }

  // 🔹 Book a tour
  Future<void> bookTour(String name, int price) async {
    if (_auth.currentUser == null) return;

    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("tours")
          .add({
        "name": name,
        "price": price,
        "createdAt": FieldValue.serverTimestamp(),
      });

      await loadMyTours();
      Get.snackbar("Success", "Tour booked successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to book tour: $e");
    }
  }
}
