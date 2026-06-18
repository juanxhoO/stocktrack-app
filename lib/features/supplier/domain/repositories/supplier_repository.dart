import '../entities/supplier.dart';

abstract class SupplierRepository {
  Future<Supplier> getSupplier(String id);

  Future<List<Supplier>> searchSuppliers({String? query});
  Future<Supplier> createSupplier({
    String? name,
    String? description,
    String? image,
  });
  Future<void> deleteSupplier(String id);
  Future<Supplier> updateSupplier({
    String? id,
    String? name,
    String? description,
    String? image,
  });
}
