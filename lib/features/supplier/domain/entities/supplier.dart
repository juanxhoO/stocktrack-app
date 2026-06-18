class Supplier {
  final String id;
  final String name;
  final String description;
  final String? image;
  final int productsCount;
  final bool status;
  final String? createdAt;
  final String? updatedAt;

  const Supplier({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.productsCount,
    required this.status,
  });
}
