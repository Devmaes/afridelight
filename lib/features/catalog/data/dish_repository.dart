import 'package:afridelight/features/catalog/domain/dish.dart';

abstract interface class DishRepository {
  Future<List<Dish>> getDishes();
  Future<Dish?> getDishById(String id);
}
