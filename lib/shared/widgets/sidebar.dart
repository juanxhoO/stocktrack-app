import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ─────────────────────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────────────────────

class NavItem {
  final String label;
  final IconData icon;
  final String? route;
  final int? badge;
  final Color? badgeColor;
  final List<NavItem> children;

  const NavItem({
    required this.label,
    required this.icon,
    this.route,
    this.badge,
    this.badgeColor,
    this.children = const [],
  });

  bool get hasChildren => children.isNotEmpty;
}

// ─────────────────────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────────────────────

const _mainItems = [
  NavItem(label: 'Dashboard', icon: Icons.dashboard_rounded, route: '/home'),

  NavItem(label: 'Inventory', icon: Icons.inventory_2_rounded),

  NavItem(
    label: 'Products',
    icon: Icons.shopping_bag_outlined,
    route: '/products',
  ),
  NavItem(
    label: 'Categories',
    icon: Icons.category_outlined,
    route: '/categories',
  ),
  NavItem(
    label: 'Warehouses',
    icon: Icons.warehouse_outlined,
    route: '/warehouses',
  ),
  NavItem(
    label: 'Users',
    icon: Icons.people_rounded,
    children: [
      NavItem(
        label: 'Administrators',
        icon: Icons.admin_panel_settings_outlined,
        route: '/users/admins',
      ),
      NavItem(
        label: 'Suppliers',
        icon: Icons.local_shipping_outlined,
        route: '/users/suppliers',
      ),
      NavItem(
        label: 'Employees',
        icon: Icons.badge_outlined,
        route: '/users/employees',
      ),
      NavItem(
        label: 'Customers',
        icon: Icons.person_outline,
        route: '/users/customers',
      ),
    ],
  ),
];

const _movItems = [
  NavItem(
    label: 'Entries',
    icon: Icons.arrow_downward_rounded,
    route: '/entries',
    badge: 3,
    badgeColor: Color(0xFF0F6E56),
  ),
  NavItem(label: 'Exits', icon: Icons.arrow_upward_rounded, route: '/exits'),
  NavItem(
    label: 'Adjustments',
    icon: Icons.sync_rounded,
    route: '/adjustments',
  ),
];

const _reportItems = [
  NavItem(label: 'Statistics', icon: Icons.bar_chart_rounded, route: '/stats'),
  NavItem(
    label: 'Low Stock',
    icon: Icons.warning_amber_rounded,
    route: '/low-stock',
    badge: 7,
    badgeColor: Color(0xFFE24B4A),
  ),
];

const _systemItems = [
  NavItem(label: 'Settings', icon: Icons.settings_rounded, route: '/settings'),
];

// ─────────────────────────────────────────────────────────────
// SIDEBAR
// ─────────────────────────────────────────────────────────────

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          const _SidebarHeader(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _NavSection(label: 'Main', items: _mainItems),

                const Divider(),

                _NavSection(label: 'Movements', items: _movItems),

                const Divider(),

                _NavSection(label: 'Reports', items: _reportItems),

                const Divider(),

                _NavSection(label: 'System', items: _systemItems),
              ],
            ),
          ),

          const Divider(height: 1),

          const _UserFooter(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// HEADER
// ─────────────────────────────────────────────────────────────

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1565C0),
      padding: const EdgeInsets.all(20),
      child: const Column(
        children: [
          Icon(Icons.inventory_2_rounded, color: Colors.white, size: 40),
          SizedBox(height: 12),
          Text(
            'StockTrack',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text('v1.0.0', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SECTION
// ─────────────────────────────────────────────────────────────

class _NavSection extends StatelessWidget {
  final String label;
  final List<NavItem> items;

  const _NavSection({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              letterSpacing: 1,
            ),
          ),
        ),

        ...items.map(
          (item) => _NavTile(item: item, currentRoute: currentLocation),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// NAV ITEM
// ─────────────────────────────────────────────────────────────

class _NavTile extends StatelessWidget {
  final NavItem item;
  final String currentRoute;

  const _NavTile({required this.item, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF1565C0);

    if (item.hasChildren) {
      return ExpansionTile(
        leading: Icon(item.icon, color: activeColor),
        title: Text(item.label),
        childrenPadding: const EdgeInsets.only(left: 20),
        children: item.children.map((child) {
          final active = currentRoute == child.route;

          return ListTile(
            selected: active,
            leading: Icon(
              child.icon,
              size: 18,
              color: active ? activeColor : null,
            ),
            title: Text(
              child.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            onTap: () {
              if (child.route != null) {
                context.go(child.route!);
              }
            },
          );
        }).toList(),
      );
    }

    final active = currentRoute == item.route;

    return ListTile(
      selected: active,
      leading: Icon(item.icon, color: active ? activeColor : null),
      title: Text(
        item.label,
        style: TextStyle(
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: item.badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: item.badgeColor ?? activeColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${item.badge}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: () {
        if (item.route != null) {
          context.go(item.route!);
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────────────────────

class _UserFooter extends StatelessWidget {
  const _UserFooter();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Text('JD')),
      title: const Text('Juan Díaz'),
      subtitle: const Text('Administrator'),
      trailing: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          // logout
        },
      ),
      onTap: () {
        context.go('/profile');
      },
    );
  }
}
