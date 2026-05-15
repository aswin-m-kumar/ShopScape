import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Product> _filter(List<Product> products) {
    if (_query.trim().isEmpty) {
      return products;
    }
    final term = _query.toLowerCase();
    return products.where((product) {
      return product.title.toLowerCase().contains(term) ||
          product.description.toLowerCase().contains(term) ||
          product.category.toLowerCase().contains(term);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFB59D);
    const textSecondary = Color(0xFF8E8E93);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (value) => setState(() => _query = value),
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            hintText: 'Search products',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.state == ProductState.loading) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (provider.state == ProductState.error) {
            return Center(
              child: Text(
                provider.errorMessage ?? 'Unable to load products',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textSecondary),
              ),
            );
          }

          final filtered = _filter(provider.products);
          if (filtered.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search_off, size: 52, color: primaryColor),
                  const SizedBox(height: 12),
                  Text(
                    'No products found',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textSecondary),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final product = filtered[index];
              return ProductCard(
                product: product,
                onTap: () => Navigator.of(context).pushNamed('/detail', arguments: product),
              );
            },
          );
        },
      ),
    );
  }
}
