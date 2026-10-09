enum DishCategory {
  chicken('Poulet'),
  fish('Poisson'),
  traditional('Plats Traditionnels'),
  side('Accompagnements');

  const DishCategory(this.label);
  final String label;
}

class Dish {
  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.isRecommended = false,
    this.sides = const <String>[],
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final String imageAsset;
  final DishCategory category;
  final double rating;
  final int reviewCount;
  final bool isRecommended;
  final List<String> sides;
}
