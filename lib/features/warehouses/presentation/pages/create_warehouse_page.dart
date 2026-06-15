import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';

class WarehouseCreatePage extends ConsumerStatefulWidget {
  const WarehouseCreatePage({super.key});

  @override
  ConsumerState<WarehouseCreatePage> createState() =>
      _WarehouseCreatePageState();
}

class _WarehouseCreatePageState extends ConsumerState<WarehouseCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final List<Map<String, dynamic>> _products = [];
  bool _showForm = false;
  String? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    setState(() => _selectedCategory = null);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(warehouseControllerProvider.notifier)
        .createWarehouse(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
        );

    if (mounted) {
      setState(() {
        _products.add({
          'name': _nameController.text.trim(),
          'description': _descriptionController.text.trim(),
          'price': double.parse(_priceController.text.trim()),
          'category': _selectedCategory,
        });
        _showForm = false;
        _clearForm();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(warehouseControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/products'),
        ),
        actions: [
          if (!_showForm)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add product',
              onPressed: () => setState(() => _showForm = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Form ──────────────────────────────────────
            Row(
              children: [
                const Text(
                  'New product',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() {
                    _showForm = false;
                    _clearForm();
                  }),
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField(
                    controller: _nameController,
                    label: 'Name',
                    hint: 'Product name',
                    icon: Icons.label_outline,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Short product description',
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    controller: _priceController,
                    label: 'Price',
                    hint: '0.00',
                    icon: Icons.attach_money_outlined,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Price is required';
                      if (double.tryParse(v) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // // ── Category dropdown ──────────────────
                  // DropdownButtonFormField<String>(
                  //   value: _selectedCategory,
                  //   decoration: InputDecoration(
                  //     labelText: 'Category',
                  //     hintText: 'Select a category',
                  //     prefixIcon: const Icon(Icons.category_outlined),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide(color: Colors.grey.shade200),
                  //     ),
                  //   ),
                  //   items: _categories
                  //       .map(
                  //         (c) => DropdownMenuItem(value: c, child: Text(c)),
                  //       )
                  //       .toList(),
                  //   onChanged: (value) =>
                  //       setState(() => _selectedCategory = value),
                  //   validator: (v) => v == null ? 'Select a category' : null,
                  // ),
                  const SizedBox(height: 16),
                  if (productState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        productState.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: productState.isLoading ? null : _submit,
                      icon: productState.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check),
                      label: Text(
                        productState.isLoading ? 'Saving...' : 'Save product',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = _products[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.blue.shade400,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if ((product['description'] as String).isNotEmpty)
                              Text(
                                product['description'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (product['category'] != null)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  product['category'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${(product['price'] as double).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red.shade300,
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _products.removeAt(index)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
