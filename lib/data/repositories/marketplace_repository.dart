import '../models/category.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/shop.dart';

class MarketplaceRepository {
  List<Category> getCategories() => const [
        Category(id: 1, name: 'Makanan', icon: '🍛'),
        Category(id: 2, name: 'Minuman', icon: '🥤'),
        Category(id: 3, name: 'Fashion', icon: '👕'),
        Category(id: 4, name: 'Kerajinan', icon: '🧺'),
        Category(id: 5, name: 'Jasa', icon: '🛠️'),
        Category(id: 6, name: 'Sembako', icon: '🛒'),
      ];

  List<Product> getProducts() => const [
        Product(
          id: 1,
          name: 'Nasi Uduk Galuh',
          category: 'Makanan',
          shopName: 'Dapur Bu Rina',
          price: 12000,
          stock: 24,
          rating: 4.8,
          imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800',
          description: 'Nasi uduk rumahan lengkap dengan orek, telur, dan sambal kacang.',
        ),
        Product(
          id: 2,
          name: 'Es Kopi Susu Tetangga',
          category: 'Minuman',
          shopName: 'Kopi Blok C',
          price: 15000,
          stock: 40,
          rating: 4.7,
          imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800',
          description: 'Kopi susu gula aren segar, cocok untuk teman kerja dari rumah.',
        ),
        Product(
          id: 3,
          name: 'Paket Sembako Hemat',
          category: 'Sembako',
          shopName: 'Warung Pak Dedi',
          price: 85000,
          stock: 12,
          rating: 4.9,
          imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800',
          description: 'Beras, minyak, gula, dan telur untuk kebutuhan keluarga.',
        ),
        Product(
          id: 4,
          name: 'Bucket Bunga Flanel',
          category: 'Kerajinan',
          shopName: 'Galuh Craft',
          price: 45000,
          stock: 8,
          rating: 4.6,
          imageUrl: 'https://images.unsplash.com/photo-1526047932273-341f2a7631f9?w=800',
          description: 'Kerajinan bunga flanel handmade untuk hadiah dan dekorasi.',
        ),
      ];

  Shop getFeaturedShop() => const Shop(
        name: 'Dapur Bu Rina',
        owner: 'Rina Kurnia',
        address: 'Blok B2 No. 17, Perum Kota Galuh',
        openHours: '06.00 - 21.00 WIB',
        rating: 4.8,
        isApproved: true,
      );

  List<LocalOrder> getOrders() => const [
        LocalOrder(
          invoice: 'INV-GLH-0001',
          customerName: 'Andi Pratama',
          total: 39000,
          status: OrderStatus.processing,
          deliveryMethod: 'Kurir internal',
        ),
        LocalOrder(
          invoice: 'INV-GLH-0002',
          customerName: 'Siti Aminah',
          total: 85000,
          status: OrderStatus.shipped,
          deliveryMethod: 'Ojek lokal',
        ),
        LocalOrder(
          invoice: 'INV-GLH-0003',
          customerName: 'Budi Santoso',
          total: 45000,
          status: OrderStatus.completed,
          deliveryMethod: 'Ambil sendiri',
        ),
      ];
}
