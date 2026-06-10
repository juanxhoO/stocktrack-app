import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/warehouse_controller.dart';

class WarehouseListPage extends ConsumerStatefulWidget {
  const WarehouseListPage({super.key});

  @override
  ConsumerState<WarehouseListPage> createState() => _WarehouseListPageState();
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
    final warehouseState = ref.watch(warehouseControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            mouseCursor: SystemMouseCursors.click,
            onPressed: () => context.go('/warehouses/create'),
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
        ref.read(warehouseControllerProvider.notifier).searchWarehouses();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: warehouses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final warehouse = warehouses[index];
          return _buildWarehouseCard(warehouse);
        },
      ),
    );
  }

  Widget _buildWarehouseCard(warehouse) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go('/warehouses/${warehouse.id}'),
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
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: warehouse.image != null
                    ? Image.network(
                        warehouse.image!,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 64,
                        height: 64,
                        color: Colors.grey.shade100,
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      warehouse.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    Text(
                      "ID: " + warehouse.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      warehouse.description ?? '',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
