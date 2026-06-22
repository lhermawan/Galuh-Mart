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
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth >= 720 ? 3 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shops.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: .58,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  return _ShopPosterCard(
                    shop: shop,
                    products: repository.getProductsByShop(shop.name).map((product) => product.name).toList(),
                    onTap: () => _openSeller(context, shop),
                  );
                },
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            _ShopPosterImage(
              imageUrl: shop.posterImageUrl,
              color: Color(shop.posterColor),
              width: 112,
              height: 112,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    Text(shop.address, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _ShopStatusBadge(openHours: shop.openHours, compact: true),
                        Text(
                          '⭐ ${shop.rating} • $productCount produk',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.chevron_right),
            ),
          ],
        ),
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
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Color(shop.posterColor)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _ShopPosterImage(
                      imageUrl: shop.posterImageUrl,
                      color: Color(shop.posterColor),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withOpacity(.08), Colors.black.withOpacity(.68)],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      right: 18,
                      bottom: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop.posterTitle,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            products.join(' • '),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        Text(
                          '${shop.category} • ⭐ ${shop.rating}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        _ShopStatusBadge(openHours: shop.openHours),
                        const SizedBox(height: 4),
                        Text(
                          shop.openHours,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
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

class _ShopStatusBadge extends StatelessWidget {
  const _ShopStatusBadge({required this.openHours, this.compact = false});

  final String openHours;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final isOpen = _ShopSchedule.isOpenNow(openHours);
    final color = isOpen ? Colors.green.shade700 : Colors.red.shade700;
    final backgroundColor = isOpen ? Colors.green.shade50 : Colors.red.shade50;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOpen ? Icons.storefront : Icons.storefront_outlined,
            size: compact ? 13 : 15,
            color: color,
          ),
          SizedBox(width: compact ? 4 : 6),
          Text(
            isOpen ? 'Buka' : 'Tutup',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _ShopSchedule {
  const _ShopSchedule._();

  static bool isOpenNow(String openHours) {
    final times = RegExp(r'(\d{2})\.(\d{2})').allMatches(openHours).toList();
    if (times.length < 2) return false;

    final now = DateTime.now();
    final open = _minutes(times.first);
    final close = _minutes(times[1]);
    final current = now.hour * 60 + now.minute;

    if (open <= close) {
      return current >= open && current <= close;
    }

    return current >= open || current <= close;
  }

  static int _minutes(RegExpMatch match) {
    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    return hour * 60 + minute;
  }
}

class _ShopPosterImage extends StatelessWidget {
  const _ShopPosterImage({
    required this.imageUrl,
    required this.color,
    this.width,
    this.height,
  });

  final String imageUrl;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: color.withOpacity(.18),
        alignment: Alignment.center,
        child: Icon(Icons.storefront, color: color),
      ),
    );
  }
}
