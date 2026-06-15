import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.label, this.onTap});
}

class AppBreadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const AppBreadcrumb({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          InkWell(
            onTap: i == items.length - 1 ? null : items[i].onTap,
            child: Text(
              items[i].label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: i == items.length - 1
                    ? theme.colorScheme.onSurface
                    : Colors.grey,
                fontWeight: i == items.length - 1
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ),
          if (i < items.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            ),
        ],
      ],
    );
  }
}
