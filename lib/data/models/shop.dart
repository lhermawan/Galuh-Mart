class Shop {
  const Shop({
    required this.name,
    required this.owner,
    required this.address,
    required this.openHours,
    required this.rating,
    required this.isApproved,
  });

  final String name;
  final String owner;
  final String address;
  final String openHours;
  final double rating;
  final bool isApproved;
}
