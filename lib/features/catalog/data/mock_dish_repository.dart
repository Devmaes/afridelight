import 'dart:async';

import 'package:afridelight/features/catalog/data/dish_repository.dart';
import 'package:afridelight/features/catalog/domain/dish.dart';

class MockDishRepository implements DishRepository {
  static const dishes = <Dish>[
    Dish(
      id: 'poulet-dg',
      name: 'Poulet DG',
      description: 'Poulet braisé, plantains mûrs, légumes frais et sauce savoureuse.',
      price: 2500,
      imageUrl: 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?auto=format&fit=crop&w=1200&q=85',
      category: DishCategory.chicken,
      rating: 4.8,
      reviewCount: 320,
      isRecommended: true,
      sides: <String>['Bâton de manioc', 'Plantain mûr'],
    ),
    Dish(
      id: 'ndole',
      name: 'Ndolé aux crevettes',
      description: 'Plat traditionnel aux feuilles de ndolé, crevettes et épices.',
      price: 2500,
      imageUrl: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=1200&q=85',
      category: DishCategory.traditional,
      rating: 4.6,
      reviewCount: 198,
      isRecommended: true,
      sides: <String>['Plantain mûr', 'Riz blanc'],
    ),
    Dish(
      id: 'mafe',
      name: 'Mafé',
      description: 'Sauce d’arachide, viande tendre et légumes.',
      price: 2000,
      imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1200&q=85',
      category: DishCategory.traditional,
      rating: 4.7,
      reviewCount: 174,
      isRecommended: true,
      sides: <String>['Riz blanc', 'Plantain mûr'],
    ),
    Dish(
      id: 'poisson-braise',
      name: 'Poisson braisé',
      description: 'Poisson grillé au feu, crudités, épices et plantain.',
      price: 2500,
      imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?auto=format&fit=crop&w=1200&q=85',
      category: DishCategory.fish,
      rating: 4.9,
      reviewCount: 241,
      sides: <String>['Plantain mûr', 'Bâton de manioc'],
    ),
    Dish(
      id: 'alloco',
      name: 'Alloco',
      description: 'Plantain mûr frit, doré et légèrement caramélisé.',
      price: 1500,
      imageUrl: 'https://images.unsplash.com/photo-1604329760661-e71dc83f8f26?auto=format&fit=crop&w=1200&q=85',
      category: DishCategory.side,
      rating: 4.7,
      reviewCount: 256,
      isRecommended: true,
    ),
  ];

  @override
  Future<Dish?> getDishById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    for (final dish in dishes) {
      if (dish.id == id) return dish;
    }
    return null;
  }

  @override
  Future<List<Dish>> getDishes() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return dishes;
  }
}
