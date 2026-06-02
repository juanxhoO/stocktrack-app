import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/product_controller.dart';

class ProductCreatePage extends ConsumerStatefulWidget {
  const ProductCreatePage({super.key});

  @override
  ConsumerState<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends ConsumerState<ProductCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(productControllerProvider.notifier).createProduct(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text.trim()),
    });
    if (mounted) context.go('/products');
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          mouseCursor: SystemMouseCursors.click,
          onPressed: () => context.go('/products'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

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
                  if (double.tryParse(v) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 32),

              if (productState.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
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
                  mouseCursor: SystemMouseCursors.click,
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.blue.withOpacity(0.8);
                      }
                      return null;
                    }),
                  ),
                  icon: productState.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: Text(
                    productState.isLoading ? 'Saving...' : 'Create Product',
                  ),
                ),
              ),
            ],
          ),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}