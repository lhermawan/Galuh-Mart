class Shop {
  const Shop({
    required this.id,
    required this.name,
    required this.owner,
    required this.category,
    required this.address,
    required this.openHours,
    required this.rating,
    required this.isApproved,
    required this.posterTitle,
    required this.posterTagline,
    required this.posterImageUrl,
    required this.posterColor,
  });

  final int id;
  final String name;
  final String owner;
  final String category;
  final String address;
  final String openHours;
  final double rating;
  final bool isApproved;
  final String posterTitle;
  final String posterTagline;
  final String posterImageUrl;
  final int posterColor;
}
