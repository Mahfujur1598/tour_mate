class Tour {
  final String id;
  final String name;
  final String description;
  final int price; // in BDT
  final double rating;
  final String duration;
  final String location;
  final String imageUrl;

  const Tour({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.duration,
    required this.location,
    required this.imageUrl,
  });

  factory Tour.fromMap(Map<String, dynamic> map) => Tour(
        id: map['id']?.toString() ?? map['name'] ?? 'tour',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        price: (map['price'] ?? 0) is int ? map['price'] : int.tryParse(map['price'].toString()) ?? 0,
        rating: (map['rating'] ?? 0).toDouble(),
        duration: map['duration'] ?? '',
        location: map['location'] ?? '',
        imageUrl: map['image'] ?? map['imageUrl'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'rating': rating,
        'duration': duration,
        'location': location,
        'image': imageUrl,
      };
}
