import '../models/tour.dart';

class TourData {
  static final List<Tour> popular = [
    Tour(
      id: 'sundarbans',
      name: 'Sundarbans Adventure',
      description: 'Explore the world’s largest mangrove forest and spot wildlife.',
      price: 12000,
      rating: 4.8,
      duration: '3 Days',
      location: 'Khulna, BD',
      imageUrl: 'assets/images/sundarbans.jpg',
    ),
    Tour(
      id: 'coxsbazar',
      name: 'Cox’s Bazar Beach Escape',
      description: 'Relax at the world’s longest natural sea beach.',
      price: 8000,
      rating: 4.6,
      duration: '2 Days',
      location: 'Cox’s Bazar, BD',
      imageUrl: 'assets/images/cox.jpg',
    ),
    Tour(
      id: 'sreemangal',
      name: 'Sreemangal Tea Trails',
      description: 'Rolling tea gardens, Lawachara forest, and quiet retreats.',
      price: 6500,
      rating: 4.7,
      duration: '2 Days',
      location: 'Moulvibazar, BD',
      imageUrl: 'assets/images/sreemangal.jpg',
    ),
  ];
}
