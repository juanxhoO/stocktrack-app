class Warehouse {
  final String id;
  final String name;
  final String description;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  const Warehouse({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });
}
