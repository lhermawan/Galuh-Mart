import 'package:flutter/material.dart';

import '../../data/models/order.dart';
import '../../data/repositories/marketplace_repository.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.repository});

  final MarketplaceRepository repository;

  @override
  Widget build(BuildContext context) {
    final orders = repository.getOrders();
    return Scaffold(
      appBar: AppBar(title: const Text('Order Management')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(order.invoice),
              subtitle: Text('${order.customerName} • ${order.deliveryMethod}\nStatus: ${order.status.label}'),
              isThreeLine: true,
              trailing: Text('Rp${order.total}', style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          );
        },
      ),
    );
  }
}
