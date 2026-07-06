import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import 'package:stocktrack_app/shared/widgets/table.dart';

class WarehousePage extends ConsumerStatefulWidget {
  final String id;
  const WarehousePage({super.key, required this.id});

  @override
  ConsumerState<WarehousePage> createState() => _WarehousePageState();
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

class _WarehousePageState extends ConsumerState<WarehousePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('WarehousePage ID: ${widget.id}');
    Future.microtask(() {
      ref.read(warehouseControllerProvider.notifier).loadWarehouse(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final warehouseState = ref.watch(warehouseControllerProvider);
    debugPrint(warehouseState.toString());
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            mouseCursor: SystemMouseCursors.click,
            onPressed: () => context.go('/products/create'),
          ),
        ],
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
                    .loadWarehouse(widget.id);
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

    final warehouse = warehouses[0];
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(warehouseControllerProvider.notifier).loadWarehouse(widget.id);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      warehouse.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        Chip(
                          avatar: const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                          ),
                          label: Text('${warehouse.city}, ${warehouse.state}'),
                        ),

                        Chip(
                          avatar: const Icon(
                            Icons.inventory_2_outlined,
                            size: 18,
                          ),
                          label: Text('${warehouse.capacity} Items'),
                        ),

                        Chip(
                          backgroundColor: warehouse.isActive
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          avatar: Icon(
                            warehouse.isActive
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            size: 18,
                            color: warehouse.isActive
                                ? Colors.green
                                : Colors.red,
                          ),
                          label: Text(
                            warehouse.isActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              color: warehouse.isActive
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Export Data'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Edit Warehouse'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;

                if (constraints.maxWidth >= 800) {
                  crossAxisCount = 3;
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
                      title: 'Capacity',
                      value: '12',
                      icon: Icons.warehouse,
                    ),
                    DashboardCard(
                      title: 'Low Stock',
                      value: '18',
                      icon: Icons.warning_amber,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: AppTable(
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
                          Text(warehouse.isActive ? 'Active' : 'Inactive'),
                          Text('${warehouse.capacity} items'),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Warehouse Info',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          const Divider(),

                          Text('Manager: ${warehouse.manager}'),
                          const SizedBox(height: 8),

                          Text('Phone: ${warehouse.phone}'),
                          const SizedBox(height: 8),

                          Text('Address: ${warehouse.address}'),
                          const SizedBox(height: 8),

                          Text('City: ${warehouse.city}'),
                          const SizedBox(height: 8),

                          Text('State: ${warehouse.state}'),
                          const SizedBox(height: 8),

                          Text('Zip: ${warehouse.zipcode}'),
                          const SizedBox(height: 8),

                          Text('Country: ${warehouse.country}'),
                          const SizedBox(height: 8),

                          Text('Total Capacity : ${warehouse.capacity}'),
                          const SizedBox(height: 8),

                          Text('Last Updated: Today'),
                        ],
                      ),
                    ),
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
