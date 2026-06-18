import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/product.dart';
import '../controllers/cart_controller.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.chat_outlined), label: const Text('Chat Seller'))),
              const SizedBox(width: 12),
              Expanded(child: FilledButton.icon(onPressed: () => _addToCart(context), icon: const Icon(Icons.add_shopping_cart), label: const Text('Keranjang'))),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(colors: [Colors.teal.shade100, Colors.amber.shade100]),
            ),
            child: Center(child: Text(product.category, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900))),
          ),
          const SizedBox(height: 20),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(product.shopName),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [Chip(label: Text('⭐ ${product.rating}')), Chip(label: Text('Stok ${product.stock}')), Chip(label: Text(product.category))]),
          const SizedBox(height: 16),
          Text('Rp${product.price}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w900)),
          const SizedBox(height: 16),
          Text(product.description),
          const SizedBox(height: 20),
          const Text('Opsi pengiriman: Ambil sendiri, Kurir internal, Ojek lokal.'),
          const SizedBox(height: 8),
          const Text('Pembayaran: Transfer Bank, QRIS, COD, atau Midtrans Payment Gateway.'),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context) {
    context.read<CartController>().add(product);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} ditambahkan ke keranjang')));
  }
}
