import 'package:afridelight/features/catalog/domain/dish.dart';

class CartItem {
  const CartItem({
    required this.dish,
    required this.quantity,
    this.selectedSide,
    this.unitPriceOverride,
  });

  final Dish dish;
  final int quantity;
  final String? selectedSide;
  final int? unitPriceOverride;

  int get unitPrice => unitPriceOverride ?? dish.price;
  int get lineTotal => unitPrice * quantity;

  CartItem copyWith({
    int? quantity,
    String? selectedSide,
    bool clearSide = false,
    int? unitPriceOverride,
  }) {
    return CartItem(
      dish: dish,
      quantity: quantity ?? this.quantity,
      selectedSide: clearSide ? null : selectedSide ?? this.selectedSide,
      unitPriceOverride: unitPriceOverride ?? this.unitPriceOverride,
    );
  }
}
