import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/shop.dart';
import '../../data/repositories/marketplace_repository.dart';
import '../controllers/cart_controller.dart';
import '../widgets/section_header.dart';
import 'auth_page.dart';
import 'seller_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.repository,
    required this.onLoginSelected,
    required this.onCartSelected,
  });

  final MarketplaceRepository repository;
  final ValueChanged<DashboardRole> onLoginSelected;
  final VoidCallback onCartSelected;

  @override
  Widget build(BuildContext context) {
    final categories = repository.getCategories();
    final shops = repository.getShops();
    final featuredShop = repository.getFeaturedShop();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GaluhMart'),
        actions: [
          Consumer<CartController>(
            builder: (context, cart, _) => Badge.count(
              count: cart.itemCount,
              isLabelVisible: cart.itemCount > 0,
              child: IconButton(onPressed: onCartSelected, icon: const Icon(Icons.shopping_cart_outlined)),
            ),
          ),
          PopupMenuButton<DashboardRole>(
            tooltip: 'Login seller/admin',
            icon: const Icon(Icons.login),
            onSelected: onLoginSelected,
            itemBuilder: (context) => const [
              PopupMenuItem(value: DashboardRole.seller, child: Text('Login Seller')),
              PopupMenuItem(value: DashboardRole.admin, child: Text('Login Admin')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari toko, penjual, atau penyedia jasa...',
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
                Text('Pilih toko dulu, lihat poster produknya, lalu belanja di halaman penjual.', style: TextStyle(color: Colors.white70)),
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
          _ShopTile(
            shop: featuredShop,
            productCount: repository.getProductsByShop(featuredShop.name).length,
            onTap: () => _openSeller(context, featuredShop),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Katalog Toko & Jasa', action: 'Buka toko'),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shops.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final shop = shops[index];
              return _ShopPosterCard(
                shop: shop,
                products: repository.getProductsByShop(shop.name).map((product) => product.name).toList(),
                onTap: () => _openSeller(context, shop),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openSeller(BuildContext context, Shop shop) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellerDetailPage(repository: repository, shop: shop)));
  }
}

class _ShopTile extends StatelessWidget {
  const _ShopTile({required this.shop, required this.productCount, required this.onTap});

  final Shop shop;
  final int productCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(Icons.storefront)),
        title: Text(shop.name),
        subtitle: Text('${shop.address}\n${shop.openHours} • ⭐ ${shop.rating} • $productCount produk'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _ShopPosterCard extends StatelessWidget {
  const _ShopPosterCard({required this.shop, required this.products, required this.onTap});

  final Shop shop;
  final List<String> products;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(shop.posterColor), Color(shop.posterColor).withOpacity(.68)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.posterTitle, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text(products.join(' • '), maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(shop.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text('${shop.category} • ⭐ ${shop.rating}', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
