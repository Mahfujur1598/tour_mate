import 'package:get/get.dart';
import '../data/tour_data.dart';
import '../models/tour.dart';

class TourController extends GetxController {
  final tours = <Tour>[].obs;
  final favorites = <String>{}.obs; // store tour IDs
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tours.assignAll(TourData.popular);
  }

  List<Tour> get filtered {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return tours;
    return tours.where((t) =>
        t.name.toLowerCase().contains(q) ||
        t.location.toLowerCase().contains(q)).toList();
  }

  bool isFavorite(String id) => favorites.contains(id);
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
  }

  Tour? byId(String id) {
    try {
      return tours.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
