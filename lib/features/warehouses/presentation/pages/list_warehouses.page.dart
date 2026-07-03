import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import 'package:stocktrack_app/shared/widgets/table.dart';
import 'package:stocktrack_app/shared/widgets/map.dart';

class WarehouseListPage extends ConsumerStatefulWidget {
  const WarehouseListPage({super.key});

  @override
  ConsumerState<WarehouseListPage> createState() => _WarehouseListPageState();
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WarehouseListPageState extends ConsumerState<WarehouseListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(warehouseControllerProvider.notifier)
          .searchWarehouses(query: null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final warehouseState = ref.watch(warehouseControllerProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          Expanded(child: _buildBody(warehouseState)),
        ],
      ),
    );
  }

  Widget _buildBody(WarehouseState warehouseState) {
    if (warehouseState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (warehouseState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              warehouseState.error!,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(warehouseControllerProvider.notifier)
                    .searchWarehouses();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final warehouses = warehouseState.warehouses;

    if (warehouses == null || warehouses.isEmpty) {
      return const Center(child: Text('No warehouses found'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(warehouseControllerProvider.notifier).searchWarehouses();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Warehouses Overview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 24),

            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;

                if (constraints.maxWidth >= 800) {
                  crossAxisCount = 4;
                }

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.6,
                  children: const [
                    DashboardCard(
                      title: 'Products',
                      value: '1,248',
                      icon: Icons.inventory_2,
                    ),
                    DashboardCard(
                      title: 'Warehouses',
                      value: '12',
                      icon: Icons.warehouse,
                    ),
                    DashboardCard(
                      title: 'Low Stock',
                      value: '18',
                      icon: Icons.warning_amber,
                    ),
                    DashboardCard(
                      title: 'Inventory Value',
                      value: '\$245,000',
                      icon: Icons.attach_money,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Warehouses',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                FilledButton(
                  onPressed: () {
                    context.go('/warehouses/create');
                  },
                  child: const Text('Create Warehouse'),
                ),
              ],
            ),

            const SizedBox(height: 16),
            AppTable(
              columns: const [
                AppTableColumn(label: 'Name'),
                AppTableColumn(label: 'Location'),
                AppTableColumn(label: 'Status'),
                AppTableColumn(label: 'Capacity'),
                AppTableColumn(label: 'Actions'),
              ],
              rows: warehouses.map((warehouse) {
                return AppTableRow(
                  cells: [
                    Text(warehouse.name),
                    Text('${warehouse.city}, ${warehouse.state}'),
                    Text(warehouse.isActive == true ? 'Active' : 'Inactive'),
                    Text(warehouse.capacity?.toString() ?? 'N/A'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            context.go('/warehouses/${warehouse.id}');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            context.go('/warehouses/edit/${warehouse.id}');
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
            // AppMap(
            //   markers: warehouses.map((warehouse) {
            //     return AppMapMarker(
            //       id: warehouse.id,
            //       title: warehouse.name,
            //       latitude: 48.8584,
            //       longitude: 2.2945,
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
