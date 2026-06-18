import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/supplier_controller.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';
import 'package:stocktrack_app/shared/widgets/table.dart';
import 'package:stocktrack_app/shared/widgets/searchInput.dart';

class SupplierListPage extends ConsumerStatefulWidget {
  const SupplierListPage({super.key});

  @override
  ConsumerState<SupplierListPage> createState() => _SupplierListPageState();
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

class _SupplierListPageState extends ConsumerState<SupplierListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(supplierControllerProvider.notifier)
          .searchSuppliers(query: null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final supplierState = ref.watch(supplierControllerProvider);
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
          Expanded(child: _buildBody(supplierState)),
        ],
      ),
    );
  }

  Widget _buildBody(SupplierState supplierState) {
    if (supplierState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (supplierState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              supplierState.error!,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(supplierControllerProvider.notifier).searchSuppliers();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final categories = supplierState.suppliers;

    if (categories == null || categories.isEmpty) {
      return const Center(child: Text('No Suppliers found'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(supplierControllerProvider.notifier)
            .searchSuppliers(query: null);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suppliers Overview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            Text('Manage suppliers overview here'),

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
                      title: 'Total Products',
                      value: '1,248',
                      icon: Icons.inventory_2,
                    ),
                    DashboardCard(
                      title: 'Total Categories',
                      value: '12',
                      icon: Icons.category,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                FilledButton(
                  onPressed: () {
                    context.go('/suppliers/create');
                  },
                  child: const Text('Add Supplier'),
                ),
              ],
            ),

            const SizedBox(height: 16),
            AppTable(
              columns: const [
                AppTableColumn(label: 'Name'),
                AppTableColumn(label: 'Description'),
                AppTableColumn(label: 'Status'),
                AppTableColumn(label: 'Number of products'),
                AppTableColumn(label: 'Actions'),
              ],
              rows: categories.map((category) {
                return AppTableRow(
                  cells: [
                    Text(category.name),
                    Text('${category.description}'),
                    Text(category.id),
                    Text('items'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            context.go('/categories/edit/${category.id}');
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
