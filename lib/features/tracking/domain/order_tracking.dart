enum DeliveryStep {
  confirmed('Commande confirmée', '07:30'),
  preparing('En préparation', '07:40'),
  onTheWay('En route', '07:50'),
  delivered('Livrée', '');

  const DeliveryStep(this.label, this.time);
  final String label;
  final String time;
}

class DeliveryTracking {
  const DeliveryTracking({
    required this.orderNumber,
    required this.summary,
    required this.currentStep,
    required this.estimatedMinutes,
    required this.driverName,
    required this.driverRating,
    required this.driverDeliveries,
  });

  final String orderNumber;
  final String summary;
  final DeliveryStep currentStep;
  final int estimatedMinutes;
  final String driverName;
  final double driverRating;
  final int driverDeliveries;
}
