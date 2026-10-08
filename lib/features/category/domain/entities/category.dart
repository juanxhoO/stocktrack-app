class Category {
  final num id;
  final String name;
  final String? description;
  final String? image;
  final String slug;
  final num? parentId;
  final bool? isParent;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;

  const Category({
    required this.parentId,
    required this.isParent,
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.slug,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
