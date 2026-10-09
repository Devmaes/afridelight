import 'package:afridelight/features/cart/application/cart_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('initial cart matches reference totals', () {
    final controller = CartController();
    expect(controller.state.subtotal, 4500);
    expect(controller.state.deliveryFee, 500);
    expect(controller.state.total, 5000);
  });

  test('AFRI10 applies ten percent discount', () {
    final controller = CartController();
    expect(controller.applyPromo('afri10'), isTrue);
    expect(controller.state.discountPercent, 10);
    expect(controller.state.total, 4550);
  });
}
