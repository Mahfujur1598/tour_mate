class DivisionSpots {
  static final Map<String, List<Map<String, dynamic>>> spots = {
    // 🌆 DHAKA DIVISION
    'Dhaka': [
      {
        'name': 'Lalbagh Fort',
        'image': 'assets/images/lalbagh.jpg',
        'description':
        'A 17th-century Mughal fort in Old Dhaka, built by Prince Muhammad Azam. One of the most iconic landmarks of Bangladesh.',
        'location': {'lat': 23.7189, 'lng': 90.3881},
      },
      {
        'name': 'Ahsan Manzil',
        'image': 'assets/images/ahsan_manzil.jpg',
        'description':
        'Also known as the Pink Palace, it was the residence of the Nawab of Dhaka, now a museum showcasing the Nawab era.',
        'location': {'lat': 23.7086, 'lng': 90.4067},
      },
      {
        'name': 'National Martyrs’ Memorial',
        'image': 'assets/images/savar.jpg',
        'description':
        'A national monument in Savar commemorating those who died in the Bangladesh Liberation War of 1971.',
        'location': {'lat': 23.8419, 'lng': 90.2550},
      },
    ],

    // 🌊 CHITTAGONG DIVISION
    'Chittagong': [
      {
        'name': 'Cox’s Bazar',
        'image': 'assets/images/cox_bazar.jpg',
        'description':
        'The world’s longest natural sea beach, stretching over 120 km along the Bay of Bengal.',
        'location': {'lat': 21.4339, 'lng': 91.9870},
      },
      {
        'name': 'Rangamati',
        'image': 'assets/images/rangamati.jpg',
        'description':
        'Known for its Kaptai Lake and scenic hills, Rangamati is a beautiful hill district perfect for boating and nature lovers.',
        'location': {'lat': 22.7324, 'lng': 92.2985},
      },
      {
        'name': 'Saint Martin’s Island',
        'image': 'assets/images/saint_martin.jpg',
        'description':
        'The only coral island of Bangladesh, famous for its crystal-clear water and marine life.',
        'location': {'lat': 20.6275, 'lng': 92.3226},
      },
    ],

    // 🌿 SYLHET DIVISION
    'Sylhet': [
      {
        'name': 'Jaflong',
        'image': 'assets/images/jaflong.jpg',
        'description':
        'A scenic area at the foothills of the Khasia-Jaintia hills, known for tea gardens and river pebbles.',
        'location': {'lat': 25.1661, 'lng': 92.0165},
      },
      {
        'name': 'Ratargul Swamp Forest',
        'image': 'assets/images/ratargul.jpg',
        'description':
        'Known as the “Amazon of Bangladesh”, this freshwater swamp forest is a rare natural wonder.',
        'location': {'lat': 25.0202, 'lng': 91.9605},
      },
      {
        'name': 'Lawachara National Park',
        'image': 'assets/images/lawachara.jpg',
        'description':
        'A protected rainforest famous for biodiversity and home to endangered species like the hoolock gibbon.',
        'location': {'lat': 24.3064, 'lng': 91.7713},
      },
    ],

    // 🏝️ BARISHAL DIVISION
    'Barishal': [
      {
        'name': 'Kuakata Sea Beach',
        'image': 'assets/images/kuakata.jpg',
        'description':
        'Known as the “Daughter of the Sea”, Kuakata offers a rare view of both sunrise and sunset over the Bay of Bengal.',
        'location': {'lat': 21.8197, 'lng': 90.1305},
      },
      {
        'name': 'Durga Sagar',
        'image': 'assets/images/durga_sagar.jpg',
        'description':
        'The largest pond in southern Bangladesh, surrounded by lush greenery and migratory birds.',
        'location': {'lat': 22.8168, 'lng': 90.3824},
      },
    ],

    // 🐅 KHULNA DIVISION
    'Khulna': [
      {
        'name': 'Sundarbans Mangrove Forest',
        'image': 'assets/images/sundarbans.jpg',
        'description':
        'The largest mangrove forest in the world and home to the Royal Bengal Tiger.',
        'location': {'lat': 21.9497, 'lng': 89.1833},
      },
      {
        'name': 'Sixty Dome Mosque (Shat Gombuj Masjid)',
        'image': 'assets/images/shat_gombuj.jpg',
        'description':
        'A UNESCO World Heritage Site located in Bagerhat, built during the Bengal Sultanate period.',
        'location': {'lat': 22.6743, 'lng': 89.7415},
      },
    ],

    // 🏯 RAJSHAHI DIVISION
    'Rajshahi': [
      {
        'name': 'Puthia Temple Complex',
        'image': 'assets/images/puthia.jpg',
        'description':
        'A historic complex featuring the largest number of ancient Hindu temples in Bangladesh.',
        'location': {'lat': 24.3634, 'lng': 88.9961},
      },
      {
        'name': 'Varendra Research Museum',
        'image': 'assets/images/varendra_museum.jpg',
        'description':
        'The oldest museum in Bangladesh, showcasing ancient artifacts from Bengal’s history.',
        'location': {'lat': 24.3724, 'lng': 88.5892},
      },
    ],

    // 🌾 RANGPUR DIVISION
    'Rangpur': [
      {
        'name': 'Tajhat Palace',
        'image': 'assets/images/tajhat_palace.jpg',
        'description':
        'A magnificent palace in Rangpur that now serves as a museum displaying ancient relics.',
        'location': {'lat': 25.7333, 'lng': 89.2667},
      },
      {
        'name': 'Kantajew Temple',
        'image': 'assets/images/kantajew_temple.jpg',
        'description':
        'A late-medieval Hindu temple in Dinajpur, renowned for its intricate terracotta artwork.',
        'location': {'lat': 25.6313, 'lng': 88.9305},
      },
    ],

    // 🌱 MYMENSINGH DIVISION
    'Mymensingh': [
      {
        'name': 'Shashi Lodge',
        'image': 'assets/images/shashi_lodge.jpg',
        'description':
        'A historic royal mansion built in the early 20th century, located beside the Brahmaputra River.',
        'location': {'lat': 24.7471, 'lng': 90.4203},
      },
      {
        'name': 'Muktagacha Rajbari',
        'image': 'assets/images/muktagacha.jpg',
        'description':
        'A classic zamindar palace symbolizing the rich heritage of Mymensingh.',
        'location': {'lat': 24.7630, 'lng': 90.2582},
      },
    ],
  };

  // Division cover images (for grid)
  static final Map<String, String> divisionImages = {
    'Dhaka': 'assets/images/division_dhaka.jpg',
    'Chittagong': 'assets/images/division_chittagong.jpg',
    'Sylhet': 'assets/images/division_sylhet.jpg',
    'Khulna': 'assets/images/division_khulna.jpg',
    'Barishal': 'assets/images/division_barishal.jpg',
    'Rajshahi': 'assets/images/division_rajshahi.jpg',
    'Rangpur': 'assets/images/division_rangpur.jpg',
    'Mymensingh': 'assets/images/division_mymensingh.jpg',
  };
}
