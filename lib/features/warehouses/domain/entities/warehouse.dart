class Warehouse {
  final num id;
  final String name;
  final String address;
  final num? capacity;
  final bool hasClimateControl;
  final String city;
  final bool isActive;
  final String state;
  final String country;
  final String zipcode;
  final String phone;
  final Map<String, dynamic>? manager;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const Warehouse({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.city,
    required this.manager,
    required this.hasClimateControl,
    required this.isActive,
    required this.state,
    required this.country,
    required this.zipcode,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
}
