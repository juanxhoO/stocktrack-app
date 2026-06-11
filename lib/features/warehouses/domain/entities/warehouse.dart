class Warehouse {
  final String id;
  final String name;
  final String address;
  final num capacity;
  final String city;
  final bool status;
  final String state;
  final String description;
  final String country;
  final String zipCode;
  final String phoneNumber;
  final String email;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  const Warehouse({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.city,
    required this.status,
    required this.description,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });
}
