import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ─── Model ────────────────────────────────────────────────────────────────────

class NavItem {
  final String label;
  final IconData icon;
  final String route;
  final int? badge;
  final Color? badgeColor;

  const NavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.badge,
    this.badgeColor,
  });
}

// ─── Data ─────────────────────────────────────────────────────────────────────

const _mainItems = [
  NavItem(
    label: 'Dashboard',
    icon: Icons.dashboard_rounded,
    route: '/dashboard',
  ),
  NavItem(
    label: 'Inventory',
    icon: Icons.inventory_2_rounded,
    route: '/inventory',
    badge: 124,
  ),
  NavItem(
    label: 'Categories',
    icon: Icons.inventory_2_rounded,
    route: '/categories',
    badge: 124,
  ),
  NavItem(
    label: 'Warehouses',
    icon: Icons.category_rounded,
    route: '/warehouses',
  ),

  NavItem(label: 'Products', icon: Icons.category_rounded, route: '/products'),
  NavItem(
    label: 'Suppliers',
    icon: Icons.local_shipping_rounded,
    route: '/suppliers',
  ),
];

const _movItems = [
  NavItem(
    label: 'Entradas',
    icon: Icons.arrow_downward_rounded,
    route: '/entries',
    badge: 3,
    badgeColor: Color(0xFF0F6E56),
  ),
  NavItem(label: 'Salidas', icon: Icons.arrow_upward_rounded, route: '/exits'),
  NavItem(label: 'Ajustes', icon: Icons.sync_rounded, route: '/adjustments'),
];

const _reportItems = [
  NavItem(
    label: 'Estadísticas',
    icon: Icons.bar_chart_rounded,
    route: '/stats',
  ),
  NavItem(
    label: 'Stock bajo',
    icon: Icons.warning_amber_rounded,
    route: '/low-stock',
    badge: 7,
    badgeColor: Color(0xFFE24B4A),
  ),
];

const _systemItems = [
  NavItem(
    label: 'Configuración',
    icon: Icons.settings_rounded,
    route: '/settings',
  ),
];

// ─── Sidebar ──────────────────────────────────────────────────────────────────

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
                _NavSection(label: 'Principal', items: _mainItems),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _NavSection(label: 'Movimientos', items: _movItems),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _NavSection(label: 'Reportes', items: _reportItems),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _NavSection(label: 'Sistema', items: _systemItems),
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

// ─── Header ───────────────────────────────────────────────────────────────────

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1565C0),
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
            ),
            child: const Icon(
              Icons.inventory_2_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Inventario Pro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'v1.0.0',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nav Section ─────────────────────────────────────────────────────────────

class _NavSection extends StatelessWidget {
  final String label;
  final List<NavItem> items;

  const _NavSection({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 16, 4),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
              letterSpacing: 0.8,
            ),
          ),
        ),
        ...items.map(
          (item) => _NavTile(item: item, isActive: currentRoute == item.route),
        ),
      ],
    );
  }
}

// ─── Nav Tile ─────────────────────────────────────────────────────────────────

class _NavTile extends StatelessWidget {
  final NavItem item;
  final bool isActive;

  const _NavTile({required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF1565C0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: ListTile(
        tileColor: isActive ? const Color(0xFFE3F0FC) : Colors.transparent,
        leading: Icon(
          item.icon,
          size: 20,
          color: isActive
              ? activeColor
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        title: Text(
          item.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive
                ? activeColor
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        trailing: item.badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: item.badgeColor ?? activeColor,
                ),
                child: Text(
                  '${item.badge}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
        onTap: () => context.go(item.route),
      ),
    );
  }
}

// ─── Footer ───────────────────────────────────────────────────────────────────

class _UserFooter extends StatelessWidget {
  const _UserFooter();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.go('/profile'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: const Color(0xFFE3F0FC),
        child: Text(
          'JD',
          style: TextStyle(
            color: Color(0xFF1565C0),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: const Text(
        'Juan Díaz',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: const Text('Administrador', style: TextStyle(fontSize: 12)),
      trailing: IconButton(
        icon: const Icon(Icons.logout_rounded, size: 20),
        onPressed: () {
          /* handle logout */
        },
      ),
    );
  }
}
