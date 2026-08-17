import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/category_controller.dart';
import '../../domain/entities/category.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import 'package:stocktrack_app/shared/widgets/selector.dart';

/// A single page that handles both creating and editing a category.
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
  String? _selectedParentId; // string para que matchee con AppDropdown<String>

  // Loader mientras se trae la categoría a editar
  bool _isInitialLoading = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _slugController = TextEditingController();
    _descriptionController = TextEditingController();

    if (widget.isEditing) {
      _isInitialLoading = true;
      // No se puede leer/escribir providers de forma segura de manera síncrona
      // dentro de initState, así que esperamos al primer frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadCategoryForEdit();
      });
    } else {
      _status = true;
      _isParent = true;
      _selectedParentId = null;
    }
  }

  Future<void> _loadCategoryForEdit() async {
    final id = widget.id;
    if (id == null) return;

    final currentState = ref.read(categoryControllerProvider);

    Category? category;

    // 1) Intentamos encontrarla en la lista que ya tiene el provider
    //    (evita un round-trip si venimos del listado).
    try {
      category = currentState.categories?.firstWhere(
        (c) => c.id == int.parse(id),
      );
    } catch (_) {
      category = null; // no estaba en la lista
    }

    // 2) Si no estaba en memoria, se la pedimos explícitamente al controller.
    if (category == null) {
      try {
        await ref
            .read(categoryControllerProvider.notifier)
            .loadCategory(widget.id!);
        category = ref.read(categoryControllerProvider).category;
      } catch (e) {
        if (mounted) {
          setState(() {
            _loadError = 'No se pudo cargar la categoría: $e';
            _isInitialLoading = false;
          });
        }
        return;
      }
    }

    if (!mounted) return;

    if (category == null) {
      setState(() {
        _loadError = 'Categoría no encontrada';
        _isInitialLoading = false;
      });
      return;
    }

    setState(() {
      _nameController.text = category!.name;
      _slugController.text = category.slug;
      _descriptionController.text = category.description ?? '';
      _status = category.status ?? true;
      _isParent = category.parentId == null;
      _selectedParentId = category.parentId?.toString();
      _isInitialLoading = false;
    });
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

    final parsedParentId =
        (_selectedParentId == null || _selectedParentId!.isEmpty)
        ? null
        : num.tryParse(_selectedParentId!);

    if (widget.isEditing) {
      success = await controller.updateCategory(
        id: widget.id.toString(),
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        status: _status,
        parentId: _isParent ? null : parsedParentId,
        description: _descriptionController.text.trim(),
      );
    } else {
      success = await controller.createCategory(
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        status: _status,
        parentId: _isParent ? null : parsedParentId,
        description: _descriptionController.text.trim(),
      );
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

    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final title = widget.isEditing ? 'Edit category' : 'New category';

    // Mientras se trae la categoría a editar, mostramos un loader
    // en vez de un form vacío que después "salta" con los datos.
    if (_isInitialLoading) {
      return Scaffold(
        drawer: isDesktop ? null : const AppSidebar(),
        appBar: AppBar(
          title: const Text('Edit Category'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/categories'),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Filter out the current category if editing (to prevent self-parenting)
    final availableCategories = widget.isEditing
        ? categoryState.categories
              ?.where((c) => c.id != int.parse(widget.id!))
              .toList()
        : categoryState.categories;

    // Create dropdown entries from categories
    final categoryEntries =
        availableCategories?.map((category) {
          return DropdownMenuEntry<String>(
            value: category.id.toString(),
            label: category.name,
            leadingIcon: Icon(Icons.category, size: 18),
          );
        }).toList() ??
        [];

    // Add a "None" option for clearing selection
    final parentEntries = [
      const DropdownMenuEntry<String>(value: '', label: 'None'),
      ...categoryEntries,
    ];

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

                    if (_loadError != null) ...[
                      const SizedBox(height: 12),
                      _ErrorBanner(message: _loadError!),
                    ],

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
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                            ),
                            SwitchListTile(
                              title: const Text('Status'),
                              subtitle: const Text('Category is operational'),
                              value: _status,
                              onChanged: (v) => setState(() => _status = v),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _FormRow(
                          children: [
                            SwitchListTile(
                              title: const Text('Is Parent?'),
                              subtitle: const Text(
                                'Category is a parent category',
                              ),
                              value: _isParent,
                              onChanged: (v) => setState(() => _isParent = v),
                              contentPadding: EdgeInsets.zero,
                            ),
                            if (!_isParent)
                              AppDropdown<String>(
                                label: 'Parent Category',
                                hintText: 'Select parent category',
                                icon: Icons.category_outlined,
                                initialSelection: _selectedParentId,
                                entries: parentEntries,
                                onSelected: (v) => setState(() {
                                  _selectedParentId = v;
                                }),
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
