import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';

class WarehousePage extends ConsumerStatefulWidget {
  final String id;
  const WarehousePage({super.key, required this.id});

  @override
  ConsumerState<WarehousePage> createState() => _WarehousePageState();
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
    return Scaffold(
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
      body: _buildBody(warehouseState),
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

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(warehouseControllerProvider.notifier).loadWarehouse(widget.id);
      },
      child: _buildWarehouseCard(warehouses[0]),
    );
  }

  Widget _buildWarehouseCard(product) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go('/products/${product.id}'),
        mouseCursor: SystemMouseCursors.click,
        hoverColor: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Price
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
