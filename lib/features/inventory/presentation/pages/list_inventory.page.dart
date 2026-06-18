import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import '../controllers/inventory_controller.dart';
import 'package:stocktrack_app/shared/widgets/table.dart';
import 'package:stocktrack_app/shared/widgets/searchInput.dart';

class InventoryListPage extends ConsumerStatefulWidget {
  const InventoryListPage({super.key});

  @override
  ConsumerState<InventoryListPage> createState() => _InventoryListPageState();
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

class _InventoryListPageState extends ConsumerState<InventoryListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(inventoryControllerProvider.notifier)
          .searchInventories(query: null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryControllerProvider);
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),

      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Inventory Stock App'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          Expanded(child: _buildBody(inventoryState)),
        ],
      ),
    );
  }

  Widget _buildBody(InventoryState inventoryState) {
    if (inventoryState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (inventoryState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              inventoryState.error!,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(inventoryControllerProvider.notifier)
                    .searchInventories();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final inventoryList = inventoryState.inventories;
    if (inventoryList == null || inventoryList.isEmpty) {
      return const Center(child: Text('No inventories found'));
    }

    final inventory = [];
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(inventoryControllerProvider.notifier).searchInventories();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inventory',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 16),
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
                      title: 'Warehouses',
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400,
                  height: 35,
                  child: AppSearchInput(
                    hintText: 'Search Category...',
                    onChanged: (value) {},
                  ),
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Export'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Add Product'),
                      ),
                    ),
                  ],
                ),
              ],
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
                      AppTableColumn(label: 'SKU'),
                      AppTableColumn(label: 'Category'),
                      AppTableColumn(label: 'Quantity'),
                      AppTableColumn(label: 'Price'),
                      AppTableColumn(label: 'Actions'),
                    ],
                    rows: inventory.map((item) {
                      return AppTableRow(
                        cells: [
                          Text(item.name),
                          Text('${item.city}, ${item.state}'),
                          Text(item.status ? 'Active' : 'Inactive'),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
