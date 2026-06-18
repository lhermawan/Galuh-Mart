import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/product.dart';
import '../../data/models/shop.dart';
import '../../data/repositories/marketplace_repository.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import 'product_detail_page.dart';

class SellerDetailPage extends StatelessWidget {
  const SellerDetailPage({super.key, required this.repository, required this.shop});

  final MarketplaceRepository repository;
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    final products = repository.getProductsByShop(shop.name);

    return Scaffold(
      appBar: AppBar(title: Text(shop.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SellerPoster(shop: shop, products: products),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.storefront, color: Colors.teal),
                      const SizedBox(width: 8),
                      Expanded(child: Text(shop.owner, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
                      if (shop.isApproved) const Icon(Icons.verified, color: Colors.teal),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(shop.category),
                  const SizedBox(height: 8),
                  Text(shop.address),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('⭐ ${shop.rating}')),
                      Chip(label: Text(shop.openHours)),
                      Chip(label: Text('${products.length} produk')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Produk dari toko ini'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) => ProductCard(
              product: products[index],
              onTap: () => _openDetail(context, products[index]),
              onAddToCart: () => _addToCart(context, products[index]),
            ),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)));
  }

  void _addToCart(BuildContext context, Product product) {
    context.read<CartController>().add(product);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} ditambahkan ke keranjang')));
  }
}

class _SellerPoster extends StatelessWidget {
  const _SellerPoster({required this.shop, required this.products});

  final Shop shop;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productNames = products.map((product) => product.name).join(' • ');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(shop.posterColor), Color(shop.posterColor).withOpacity(.72)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(shop.posterTitle, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(shop.posterTagline, style: const TextStyle(color: Colors.white70, height: 1.4)),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.16), borderRadius: BorderRadius.circular(18)),
            child: Text(productNames, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
