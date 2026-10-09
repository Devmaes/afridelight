import 'package:afridelight/features/tracking/data/mock_tracking_repository.dart';
import 'package:afridelight/features/tracking/domain/order_tracking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackingRepositoryProvider = Provider<MockTrackingRepository>(
  (ref) => MockTrackingRepository(),
);

final currentTrackingProvider = FutureProvider<DeliveryTracking>(
  (ref) => ref.watch(trackingRepositoryProvider).getCurrentOrder(),
);
