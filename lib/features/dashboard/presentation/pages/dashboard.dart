import 'package:flutter/material.dart';
import 'package:stocktrack_app/features/dashboard/presentation/pages/chartBar.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          const Expanded(child: _DashboardContent()),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inventory Overview',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 24),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
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
          ),

          const SizedBox(height: 32),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _ChartPlaceholder()),
              const SizedBox(width: 16),
              Expanded(child: _RecentActivityCard()),
            ],
          ),
        ],
      ),
    );
  }
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

class _ChartPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 350,
        child: Center(
          child: BarChartSample3(),
          // child: Text(
          //   'Inventory Trends Chart',
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
        ),
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 350,
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Added 50 Laptops'),
              subtitle: Text('2 minutes ago'),
            ),
            ListTile(
              leading: Icon(Icons.remove_circle_outline),
              title: Text('Sold 12 Monitors'),
              subtitle: Text('15 minutes ago'),
            ),
            ListTile(
              leading: Icon(Icons.sync),
              title: Text('Stock Adjustment'),
              subtitle: Text('1 hour ago'),
            ),
          ],
        ),
      ),
    );
  }
}
