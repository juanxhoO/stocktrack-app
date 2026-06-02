import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/product_controller.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productControllerProvider.notifier).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productControllerProvider);

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
      body: _buildBody(productState),
    );
  }

  Widget _buildBody(ProductState productState) {
    if (productState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (productState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              productState.error!,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(productControllerProvider.notifier).loadProducts();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final products = productState.products;
    if (products == null || products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(productControllerProvider.notifier).loadProducts();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(product) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go('/products/detail/${product.id}'),
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
                child: product.imageUrl != null
                    ? Image.network(
                        product.imageUrl!,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 64,
                        height: 64,
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.inventory_2_outlined,
                            color: Colors.grey),
                      ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description ?? '',
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