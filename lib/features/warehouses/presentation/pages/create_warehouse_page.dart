import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';
import '../../domain/entities/warehouse.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import 'package:stocktrack_app/shared/widgets/selector.dart';
import '../../../users/presentation/controllers/user_controller.dart';

/// A single page that handles both creating and editing a warehouse.
///
/// - [warehouse] == null  →  Create mode
/// - [warehouse] != null  →  Edit mode (fields are pre-filled)
class WarehouseFormPage extends ConsumerStatefulWidget {
  final Warehouse? warehouse;

  const WarehouseFormPage({super.key, this.warehouse});

  bool get isEditing => warehouse != null;

  @override
  ConsumerState<WarehouseFormPage> createState() => _WarehouseFormPageState();
}

class _WarehouseFormPageState extends ConsumerState<WarehouseFormPage> {
  final _formKey = GlobalKey<FormState>();

  // ── Basic Information ────────────────────────────────────────────────
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _phoneController;
  late final TextEditingController _managerController;

  // ── Location Details ─────────────────────────────────────────────────
  late final TextEditingController _countryController;
  late final TextEditingController _stateController;
  late final TextEditingController _cityController;
  late final TextEditingController _postalCodeController;
  late final TextEditingController _addressController;

  // ── Capacity & Capabilities ──────────────────────────────────────────
  late final TextEditingController _capacityController;
  bool _hasClimateControl = false;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    final w = widget.warehouse;

    _nameController = TextEditingController(text: w?.name ?? '');
    _codeController = TextEditingController(); // not on entity yet
    _phoneController = TextEditingController(text: w?.phone ?? '');
    _managerController = TextEditingController(text: w?.manager?['id'] ?? '');
    _countryController = TextEditingController(text: w?.country ?? '');
    _stateController = TextEditingController(text: w?.state ?? '');
    _cityController = TextEditingController(text: w?.city ?? '');
    _postalCodeController = TextEditingController(text: w?.zipcode ?? '');
    _addressController = TextEditingController(text: w?.address ?? '');

    _capacityController = TextEditingController(
      text: w?.capacity?.toString() ?? '',
    );
    _hasClimateControl = w?.hasClimateControl ?? false;
    _isActive = w?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _phoneController.dispose();
    _managerController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _addressController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(warehouseControllerProvider.notifier);
    final int? capacity = int.tryParse(_capacityController.text.trim());

    bool success;

    if (widget.isEditing) {
      success = await controller.updateWarehouse(
        id: widget.warehouse!.id.toString(),
        name: _nameController.text.trim(),
        code: _codeController.text.trim().isEmpty
            ? null
            : _codeController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        manager: _managerController.text.trim(),
        state_: _stateController.text.trim(),
        country: _countryController.text.trim(),
        zipcode: _postalCodeController.text.trim(),
        capacity: capacity,
        hasClimateControl: _hasClimateControl,
        isActive: _isActive,
      );
    } else {
      success = await controller.createWarehouse(
        name: _nameController.text.trim(),
        code: _codeController.text.trim().isEmpty
            ? null
            : _codeController.text.trim(),
        phone: _phoneController.text.trim(),
        manager: _managerController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        state_: _stateController.text.trim(),
        country: _countryController.text.trim(),
        zipcode: _postalCodeController.text.trim(),
        capacity: capacity,
        hasClimateControl: _hasClimateControl,
        isActive: _isActive,
      );
      print('success create warehouse: $success');
    }

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Warehouse updated successfully!'
                : 'Warehouse created successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/warehouses');
    }
  }

  @override
  Widget build(BuildContext context) {
    final warehouseState = ref.watch(warehouseControllerProvider);
    final users = ref.watch(userControllerProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final title = widget.isEditing ? 'Edit warehouse' : 'New warehouse';
    final managerEntries = [
      const DropdownMenuEntry<String>(value: '1', label: 'John Doe'),
      const DropdownMenuEntry<String>(value: '2', label: 'Jane Smith'),
      const DropdownMenuEntry<String>(value: '3', label: 'Michael Johnson'),
    ];
    String? selectedManager;
    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Warehouse' : 'Create Warehouse'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/warehouses'),
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
                          onPressed: () => context.go('/warehouses'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: warehouseState.isLoading ? null : _submit,
                          icon: warehouseState.isLoading
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
                            warehouseState.isLoading
                                ? 'Saving...'
                                : widget.isEditing
                                ? 'Save changes'
                                : 'Create warehouse',
                          ),
                        ),
                      ],
                    ),

                    if (warehouseState.error != null) ...[
                      const SizedBox(height: 12),
                      _ErrorBanner(message: warehouseState.error!),
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
                              hint: 'Warehouse name',
                              icon: Icons.warehouse_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Name is required'
                                  : null,
                            ),
                            // _buildField(
                            //   controller: _codeController,
                            //   label: 'Code',
                            //   hint: 'e.g. WH-001',
                            //   icon: Icons.qr_code_outlined,
                            // ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _FormRow(
                          children: [
                            _buildField(
                              controller: _phoneController,
                              label: 'Phone',
                              hint: '+1 555 000 0000',
                              icon: Icons.phone_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Phone is required'
                                  : null,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Location Details ─────────────────────────────
                    _SectionCard(
                      title: 'Location Details',
                      children: [
                        _FormRow(
                          children: [
                            _buildField(
                              controller: _countryController,
                              label: 'Country',
                              hint: 'United States',
                              icon: Icons.flag_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Country is required'
                                  : null,
                            ),
                            _buildField(
                              controller: _stateController,
                              label: 'State / Province',
                              hint: 'New York',
                              icon: Icons.map_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'State / Province is required'
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _FormRow(
                          children: [
                            _buildField(
                              controller: _cityController,
                              label: 'City',
                              hint: 'Brooklyn',
                              icon: Icons.location_city_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'City is required'
                                  : null,
                            ),
                            _buildField(
                              controller: _postalCodeController,
                              label: 'Postal Code',
                              hint: '10001',
                              icon: Icons.markunread_mailbox_outlined,
                            ),
                            _buildField(
                              controller: _addressController,
                              label: 'Address',
                              hint: '123 Main St',
                              icon: Icons.place_outlined,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Address is required'
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Capacity & Capabilities ──────────────────────
                    _SectionCard(
                      title: 'Capacity & Capabilities',
                      children: [
                        _FormRow(
                          children: [
                            _buildField(
                              controller: _capacityController,
                              label: 'Capacity (units)',
                              hint: '500',
                              icon: Icons.storage_outlined,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (v) {
                                if (v != null &&
                                    v.isNotEmpty &&
                                    int.tryParse(v) == null) {
                                  return 'Enter a valid number';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: SwitchListTile(
                                title: const Text('Climate Control'),
                                subtitle: const Text(
                                  'Temperature / humidity regulated',
                                ),
                                value: _hasClimateControl,
                                onChanged: (v) =>
                                    setState(() => _hasClimateControl = v),
                              ),
                            ),
                            Expanded(
                              child: SwitchListTile(
                                title: const Text('Active'),
                                subtitle: const Text(
                                  'Warehouse is operational',
                                ),
                                value: _isActive,
                                onChanged: (v) => setState(() => _isActive = v),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // ── Manager Assignment ─────────────────────────────
                    _SectionCard(
                      title: 'Manager Assignment',
                      children: [
                        _FormRow(
                          children: [
                            AppDropdown<String>(
                              width: 300,
                              label: 'Manager',
                              hintText: 'Select a manager',
                              icon: Icons.person_outline,
                              initialSelection: selectedManager,
                              entries: managerEntries,
                              onSelected: (v) => setState(() => print(v)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
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
typedef WarehouseCreatePage = WarehouseFormPage;
