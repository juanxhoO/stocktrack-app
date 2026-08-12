import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/category_controller.dart';
import '../../domain/entities/category.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import 'package:stocktrack_app/shared/widgets/selector.dart';
import '../../../users/presentation/controllers/user_controller.dart';

/// A single page that handles both creating and editing a category.
///
/// - [category] == null  →  Create mode
/// - [category] != null  →  Edit mode (fields are pre-filled)

class CategoryFormPage extends ConsumerStatefulWidget {
  final String? id;

  const CategoryFormPage({super.key, this.id});

  bool get isEditing => id != null;

  @override
  ConsumerState<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends ConsumerState<CategoryFormPage> {
  final _formKey = GlobalKey<FormState>();

  // ── Basic Information ────────────────────────────────────────────────
  late final TextEditingController _nameController;
  late final TextEditingController _slugController;
  late final TextEditingController _descriptionController;
  bool _status = true;
  bool _isParent = false;
  num? _selectedParentId; // Add this for parent category selection

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      Future.microtask(() {
        ref
            .read(categoryControllerProvider.notifier)
            .loadCategory(widget.id as String);
      });
    }
    final category = ref.watch(categoryControllerProvider).category;

    print('Category Data: ${category}');
    _nameController = TextEditingController(text: category?.name ?? '');
    _slugController = TextEditingController();
    _descriptionController = TextEditingController();
    _status = category?.status ?? true;
    _isParent = category?.parentId == null;
    _selectedParentId = category?.parentId; // Set initial parent if editing
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(categoryControllerProvider.notifier);

    bool success;

    if (widget.isEditing) {
      success = await controller.updateCategory(
        id: widget.id.toString(),
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        status: _status,
        parentId: _isParent ? null : _selectedParentId, // Add parentId
        description: _descriptionController.text.trim(),
      );
    } else {
      success = await controller.createCategory(
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        status: _status,
        parentId: _isParent ? null : _selectedParentId, // Add parentId
        description: _descriptionController.text.trim(),
      );
      print('success create category: $success');
    }

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Category updated successfully!'
                : 'Category created successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryControllerProvider);
    // Filter out the current category if editing (to prevent self-parenting)
    final categories = ref.watch(
      categoryControllerProvider,
    ); // Get all categories

    final availableCategories = widget.isEditing
        ? categories.categories
              ?.where((c) => c.id != int.parse(widget.id!))
              .toList()
        : categories.categories;

    // Create dropdown entries from categories
    final categoryEntries =
        availableCategories?.map((category) {
          return DropdownMenuEntry<String>(
            value: category.id.toString(),
            label: category.name,
            // Optional: add leading icon or trailing text
            leadingIcon: Icon(Icons.category, size: 18),
          );
        }).toList() ??
        [];

    // Add a "None" option for clearing selection
    final parentEntries = [
      const DropdownMenuEntry<String>(value: '', label: 'None'),
      ...categoryEntries,
    ];

    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final title = widget.isEditing ? 'Edit category' : 'New category';

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Category' : 'Create Category'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/categories'),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Page header ──────────────────────────────────
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => context.go('/categories'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: categoryState.isLoading ? null : _submit,
                          icon: categoryState.isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  widget.isEditing
                                      ? Icons.save_outlined
                                      : Icons.add,
                                ),
                          label: Text(
                            categoryState.isLoading
                                ? 'Saving...'
                                : widget.isEditing
                                ? 'Save changes'
                                : 'Create category',
                          ),
                        ),
                      ],
                    ),

                    if (categoryState.error != null) ...[
                      const SizedBox(height: 12),
                      _ErrorBanner(message: categoryState.error!),
                    ],

                    const SizedBox(height: 24),

                    // ── Basic Information ────────────────────────────
                    _SectionCard(
                      title: 'Basic Information',
                      children: [
                        _FormRow(
                          children: [
                            _buildField(
                              controller: _nameController,
                              label: 'Name *',
                              hint: 'Category name',
                              icon: Icons.category_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Name is required'
                                  : null,
                            ),
                            _buildField(
                              controller: _slugController,
                              label: 'Slug',
                              hint: 'Category slug',
                              icon: Icons.category_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Slug is required'
                                  : null,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _FormRow(
                          children: [
                            _buildField(
                              controller: _descriptionController,
                              label: 'Description',
                              hint: 'Category description',
                              icon: Icons.category_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Description is required'
                                  : null,
                              keyboardType: TextInputType
                                  .multiline, // Changed from TextInputType.text
                              maxLines:
                                  8, // Add this to allow multiple lines, or use null for unlimited
                            ),
                            Expanded(
                              child: SwitchListTile(
                                title: const Text('Status'),
                                subtitle: const Text('Category is operational'),
                                value: _status,
                                onChanged: (v) => setState(() => _status = v),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _FormRow(
                          children: [
                            Expanded(
                              child: SwitchListTile(
                                title: const Text('Is Parent?'),
                                subtitle: const Text(
                                  'Category is a parent category',
                                ),
                                value: _isParent,
                                onChanged: (v) => setState(() => _isParent = v),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            if (!_isParent)
                              Expanded(
                                child: AppDropdown<String>(
                                  label: 'Parent Category',
                                  hintText: 'Select parent category',
                                  icon: Icons.category_outlined,
                                  initialSelection:
                                      _selectedParentId as String?,
                                  entries: parentEntries,
                                  onSelected: (v) => setState(() {
                                    _selectedParentId = v as num?;
                                  }),
                                  // Add loading state
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ],
                ),
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
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}

// ── Small helper widgets ────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

/// Lays out children in a [Wrap] so they flow to the next line on narrow screens.
class _FormRow extends StatelessWidget {
  final List<Widget> children;

  const _FormRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: children
          .map(
            (child) => ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 260, maxWidth: 340),
              child: child,
            ),
          )
          .toList(),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;

  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.red.shade700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// Keep this alias so the existing router import still compiles.
typedef CategoryCreatePage = CategoryFormPage;
