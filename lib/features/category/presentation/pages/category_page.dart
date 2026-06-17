import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import '../controllers/category_controller.dart';
import 'package:stocktrack_app/shared/widgets/table.dart';
import 'package:stocktrack_app/shared/widgets/progressbar.dart';

class CategoryPage extends ConsumerStatefulWidget {
  final String id;
  const CategoryPage({super.key, required this.id});

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
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

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('CategoryPage ID: ${widget.id}');
    Future.microtask(() {
      ref.read(categoryControllerProvider.notifier).loadCategory(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryControllerProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),

      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            mouseCursor: SystemMouseCursors.click,
            onPressed: () => context.go('/categories/create'),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          Expanded(child: _buildBody(categoryState)),
        ],
      ),
    );
  }

  Widget _buildBody(CategoryState categoryState) {
    if (categoryState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categoryState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              categoryState.error!,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(categoryControllerProvider.notifier)
                    .loadCategory(widget.id);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final categories = categoryState.categories;
    if (categories == null || categories.isEmpty) {
      return const Center(child: Text('No categories found'));
    }

    final category = categories[0];

    final products = [
      {
        "id": "1",
        "name": "Product 1",
        "sku": "SKU1",
        "stock": 10,
        "status": true,
      },
    ];
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(categoryControllerProvider.notifier).loadCategory(widget.id);
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
                      category.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      category.description ?? 'Main category',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
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
                          label: Text('${category.description}'),
                        ),

                        Chip(
                          backgroundColor: category.status
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          avatar: Icon(
                            category.status
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            size: 18,
                            color: category.status ? Colors.green : Colors.red,
                          ),
                          label: Text(
                            category.status ? 'Active' : 'Inactive',
                            style: TextStyle(
                              color: category.status
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
                    rows: products.map((product) {
                      return AppTableRow(
                        cells: [
                          Text("dsdsd"),
                          Text("Active"),
                          Text("10"),
                          Text("SKU1"),
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
                  flex: 2,
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
                          AppProgressBar(
                            label: 'Storage Used',
                            value: 0.84,
                            trailingText: '840 / 1000',
                            color: Colors.green,
                          ),

                          const SizedBox(height: 12),
                          AppProgressBar(
                            label: 'Storage Used',
                            value: 0.84,
                            trailingText: '840 / 1000',
                          ),
                          const SizedBox(height: 12),
                          AppProgressBar(
                            label: 'Storage Used',
                            value: 0.84,
                            trailingText: '840 / 1000',
                          ),
                          const SizedBox(height: 12),
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
