import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.slug,
    super.isParent,
    super.parentId,
    super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as num,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      slug: json['slug'] as String,
      status: json['status'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'slug': slug,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
