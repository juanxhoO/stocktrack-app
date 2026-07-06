import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.entries,
    required this.onSelected,
    this.initialSelection,
    this.width,
    this.enabled = true,
    this.helperText,
    this.hintText,
  });

  final String label;
  final IconData icon;
  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final T? initialSelection;
  final double? width;
  final bool enabled;
  final String? helperText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      width: width,
      enabled: enabled,
      initialSelection: initialSelection,
      dropdownMenuEntries: entries,
      onSelected: onSelected,
      enableSearch: true,
      enableFilter: true,
      requestFocusOnTap: true,
      menuHeight: 300,
      hintText: hintText,
      leadingIcon: Icon(icon),
      label: Text(label),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
