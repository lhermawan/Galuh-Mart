enum OrderStatus { pending, processing, shipped, completed, cancelled }

extension OrderStatusLabel on OrderStatus {
  String get label => switch (this) {
        OrderStatus.pending => 'Pending',
        OrderStatus.processing => 'Diproses',
        OrderStatus.shipped => 'Dikirim',
        OrderStatus.completed => 'Selesai',
        OrderStatus.cancelled => 'Dibatalkan',
      };
}

class LocalOrder {
  const LocalOrder({
    required this.invoice,
    required this.customerName,
    required this.total,
    required this.status,
    required this.deliveryMethod,
  });

  final String invoice;
  final String customerName;
  final int total;
  final OrderStatus status;
  final String deliveryMethod;
}
