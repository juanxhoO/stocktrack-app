import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/inventory_controller.dart';

class InventoryListPage extends ConsumerStatefulWidget {
  const InventoryListPage({super.key});

  @override
  ConsumerState<InventoryListPage> createState() => _InventoryListPageState();
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

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: _buildBody(inventoryState),
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

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(inventoryControllerProvider.notifier).searchInventories();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: inventoryList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final inventory = inventoryList[index];
          return _buildProductCard(inventory);
        },
      ),
    );
  }

  Widget _buildProductCard(inventory) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go('/products/${inventory.id}'),
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
                child: inventory.image != null
                    ? Image.network(
                        inventory.image!,
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
                      inventory.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    Text(
                      "ID: " + inventory.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      inventory.description ?? '',
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
              // Price
              Text(
                '\$${inventory.price.toStringAsFixed(2)}',
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
