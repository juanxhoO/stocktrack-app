import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';

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
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(
        title: const Text('Warehouses'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/warehouses'),
        ),
        actions: [
          if (!_showForm)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add warehouse',
              onPressed: () => setState(() => _showForm = true),
            ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      const Text(
                        'New warehouse',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          context.go('/warehouses');
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildField(
                          controller: _nameController,
                          label: 'Name',
                          hint: 'Warehouse name',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Name',
                          hint: 'Warehouse Code',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Street Address',
                          hint: 'Street Address',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'City',
                          hint: 'City',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'State/Province',
                          hint: 'State/Province',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Postal Code',
                          hint: 'Postal Code',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Phone Number',
                          hint: 'Phone Number',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Email',
                          hint: 'Email',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'TOTAL AREA (SQ.FT)',
                          hint: 'Total Area',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Capacity',
                          hint: 'Capacity',
                          icon: Icons.warehouse_outlined,
                        ),
                        _buildField(
                          controller: _nameController,
                          label: 'Manager',
                          hint: 'Manager Name',
                          icon: Icons.warehouse_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
