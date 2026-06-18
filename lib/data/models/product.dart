class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.shopName,
    required this.sellerWhatsApp,
    required this.price,
    required this.stock,
    required this.rating,
    required this.imageUrl,
    required this.description,
  });

  final int id;
  final String name;
  final String category;
  final String shopName;
  final String sellerWhatsApp;
  final int price;
  final int stock;
  final double rating;
  final String imageUrl;
  final String description;
}
