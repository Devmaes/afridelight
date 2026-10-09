import 'dart:async';

import 'package:afridelight/features/tracking/domain/order_tracking.dart';

class MockTrackingRepository {
  Future<DeliveryTracking> getCurrentOrder() async {
    await Future<void>.delayed(const Duration(milliseconds: 380));

    return const DeliveryTracking(
      orderNumber: '#1234',
      summary: 'Poulet DG + Alloco',
      currentStep: DeliveryStep.onTheWay,
      estimatedMinutes: 20,
      driverName: 'Koffi Mensah',
      driverRating: 4.8,
      driverDeliveries: 125,
    );
  }
}
