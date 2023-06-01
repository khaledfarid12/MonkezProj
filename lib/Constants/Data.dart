import 'package:flutter/foundation.dart';

class Category {
  late String name;
  late String image;

  Category({
    required this.name,
    required this.image,
  });
}
class FakeData {
  final List<Category> categoriesList = <Category>[
    Category(name: 'Family Community', image: 'Assets/images/family.png'),
    Category(name: 'Service needs', image: 'Assets/images/ServiceNeeds.png'),
    Category(name: 'Guidance', image: 'Assets/images/guidance.png'),
    Category(name: 'Travel Guide', image: 'Assets/images/TravelGuide.png'),
    Category(name: 'Contact us', image: 'Assets/images/ContactUs.png'),
    Category(name: 'Nearest building', image: 'Assets/images/NearestBuilding.png'),


  ];

}