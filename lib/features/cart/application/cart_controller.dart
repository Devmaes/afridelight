import 'package:afridelight/features/cart/domain/cart_item.dart';
import 'package:afridelight/features/catalog/data/mock_dish_repository.dart';
import 'package:afridelight/features/catalog/domain/dish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartState {
  const CartState({
    required this.items,
    this.discountPercent = 0,
    this.promoCode,
  });

  final List<CartItem> items;
  final int discountPercent;
  final String? promoCode;

  int get subtotal =>
      items.fold<int>(0, (sum, item) => sum + item.lineTotal);
  int get deliveryFee => items.isEmpty ? 0 : 500;
  int get discount => (subtotal * discountPercent / 100).round();
  int get total => subtotal - discount + deliveryFee;

  CartState copyWith({
    List<CartItem>? items,
    int? discountPercent,
    String? promoCode,
    bool clearPromo = false,
  }) {
    return CartState(
      items: items ?? this.items,
      discountPercent: discountPercent ?? this.discountPercent,
      promoCode: clearPromo ? null : promoCode ?? this.promoCode,
    );
  }
}

class CartController extends StateNotifier<CartState> {
  CartController() : super(CartState(items: _initialItems()));

  static List<CartItem> _initialItems() {
    final dishes = MockDishRepository.dishes;
    final poulet = dishes.firstWhere((dish) => dish.id == 'poulet-dg');
    final ndole = dishes.firstWhere((dish) => dish.id == 'ndole');

    return <CartItem>[
      CartItem(dish: poulet, quantity: 1, selectedSide: 'Plantain mûr'),
      CartItem(
        dish: ndole,
        quantity: 1,
        selectedSide: 'Plantain mûr',
        unitPriceOverride: 2000,
      ),
    ];
  }

  void addDish(
    Dish dish, {
    int quantity = 1,
    String? selectedSide,
  }) {
    final index = state.items.indexWhere(
      (item) => item.dish.id == dish.id && item.selectedSide == selectedSide,
    );

    if (index == -1) {
      state = state.copyWith(
        items: <CartItem>[
          ...state.items,
          CartItem(
            dish: dish,
            quantity: quantity,
            selectedSide: selectedSide,
          ),
        ],
      );
      return;
    }

    final updated = [...state.items];
    updated[index] = updated[index].copyWith(
      quantity: updated[index].quantity + quantity,
    );
    state = state.copyWith(items: updated);
  }

  void incrementAt(int index) {
    final updated = [...state.items];
    updated[index] = updated[index].copyWith(
      quantity: updated[index].quantity + 1,
    );
    state = state.copyWith(items: updated);
  }

  void decrementAt(int index) {
    final current = state.items[index];
    if (current.quantity <= 1) {
      removeAt(index);
      return;
    }
    final updated = [...state.items];
    updated[index] = current.copyWith(quantity: current.quantity - 1);
    state = state.copyWith(items: updated);
  }

  void removeAt(int index) {
    final updated = [...state.items]..removeAt(index);
    state = state.copyWith(items: updated);
  }

  bool applyPromo(String rawCode) {
    final code = rawCode.trim().toUpperCase();
    if (code == 'AFRI10') {
      state = state.copyWith(promoCode: code, discountPercent: 10);
      return true;
    }
    state = state.copyWith(discountPercent: 0, clearPromo: true);
    return false;
  }
}

final cartControllerProvider =
    StateNotifierProvider<CartController, CartState>(
  (ref) => CartController(),
);
