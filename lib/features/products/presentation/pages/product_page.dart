import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/product_controller.dart';

class ProductPage extends ConsumerStatefulWidget {
  final String id;
  const ProductPage({super.key, required this.id});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('ProductPage ID: ${widget.id}');
    Future.microtask(() {
      ref.read(productControllerProvider.notifier).loadProduct(widget.id);
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
                ref.read(productControllerProvider.notifier).loadProduct(widget.id);
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
        ref.read(productControllerProvider.notifier).loadProduct(widget.id);
      },
      child: _buildProductCard(products[0])
    );
  }

  Widget _buildProductCard(product) {
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