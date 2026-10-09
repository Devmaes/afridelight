import 'dart:async';

import 'package:afridelight/features/catalog/data/dish_repository.dart';
import 'package:afridelight/features/catalog/domain/dish.dart';

class MockDishRepository implements DishRepository {
  static const dishes = <Dish>[
    Dish(
      id: 'poulet-dg',
      name: 'Poulet DG',
      description:
          'Un délicieux plat de poulet braisé accompagné de plantains mûrs, '
          'de légumes frais et d’une sauce savoureuse aux saveurs d’Afrique.',
      price: 2500,
      imageAsset: 'assets/images/poulet_dg.jpg',
      category: DishCategory.chicken,
      rating: 4.8,
      reviewCount: 320,
      isRecommended: true,
      sides: <String>['Bâton de manioc', 'Plantain mûr'],
    ),
    Dish(
      id: 'ndole',
      name: 'Ndolé aux crevettes',
      description:
          'Plat traditionnel avec des crevettes, des feuilles de ndolé et '
          'des épices savoureuses.',
      price: 2500,
      imageAsset: 'assets/images/ndole.jpg',
      category: DishCategory.traditional,
      rating: 4.6,
      reviewCount: 198,
      isRecommended: true,
      sides: <String>['Plantain mûr', 'Riz blanc'],
    ),
    Dish(
      id: 'mafe',
      name: 'Mafé',
      description:
          'Plat à base de sauce d’arachide, tendre viande et légumes.',
      price: 2000,
      imageAsset: 'assets/images/mafe.jpg',
      category: DishCategory.traditional,
      rating: 4.7,
      reviewCount: 174,
      sides: <String>['Riz blanc', 'Plantain mûr'],
    ),
    Dish(
      id: 'poisson-braise',
      name: 'Poisson braisé',
      description:
          'Poisson braisé au feu, servi avec crudités, épices et plantain.',
      price: 2500,
      imageAsset: 'assets/images/poisson_braise.jpg',
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
      imageAsset: 'assets/images/alloco.jpg',
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
    await Future<void>.delayed(const Duration(milliseconds: 560));
    return dishes;
  }
}
