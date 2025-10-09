import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var searchQuery = ''.obs;


  var allTours = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTours();
  }


  void fetchTours() {
    FirebaseFirestore.instance
        .collection('tours')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      allTours.value =
          snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();

      //Debug print
      print("🔥 Fetched tours: ${allTours.length}");
      for (var tour in allTours) {
        print(tour);
      }
    });
  }


  /// Filtered tours based on search
  List<Map<String, dynamic>> get filteredTours {
    if (searchQuery.value.isEmpty) {
      return allTours;
    }
    return allTours
        .where((tour) =>
    (tour['name'] as String)
        .toLowerCase()
        .contains(searchQuery.value.toLowerCase()) ||
        (tour['location'] as String)
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  /// Update search query
  void updateSearch(String query) {
    searchQuery.value = query;
  }

  /// Change Bottom Navigation tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
