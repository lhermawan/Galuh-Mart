import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../data/repositories/marketplace_repository.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.repository});

  final MarketplaceRepository repository;

  @override
  Widget build(BuildContext context) {
    final categories = repository.getCategories();
    final products = repository.getProducts();
    final shop = repository.getFeaturedShop();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GaluhMart'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari makanan, minuman, jasa...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(colors: [Color(0xFF0F766E), Color(0xFF14B8A6)]),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Marketplace UMKM Perum Kota Galuh', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('Belanja produk tetangga, bayar via QRIS/COD, kirim dengan kurir lokal.', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Kategori', action: 'Lihat semua'),
          const SizedBox(height: 12),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => Chip(
                avatar: Text(categories[index].icon),
                label: Text(categories[index].name),
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
          const SectionHeader(title: 'Toko Pilihan'),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.storefront)),
              title: Text(shop.name),
              subtitle: Text('${shop.address}\n${shop.openHours} • ⭐ ${shop.rating}'),
              isThreeLine: true,
              trailing: const Icon(Icons.verified, color: Colors.teal),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Produk Lokal', action: 'Promo'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .72, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemBuilder: (context, index) => ProductCard(
              product: products[index],
              onTap: () => _openDetail(context, products[index]),
            ),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)));
  }
}
