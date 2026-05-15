import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/category_mapper.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    const surfaceContainer = Color(0xFF201F1F);
    const dividerColor = Color(0xFF3A3A3C);
    const primaryColor = Color(0xFFFFB59D);
    const primaryContainer = Color(0xFFFF6B35);
    const onPrimaryContainer = Color(0xFF5F1900);
    const textPrimary = Color(0xFFFFFFFF);
    const textSecondary = Color(0xFF8E8E93);

    return SafeArea(
      top: false,
      child: Consumer<ProductProvider>(builder: (context, provider, _) {
        if (provider.state == ProductState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }

        if (provider.state == ProductState.error) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 54, color: primaryColor),
                  const SizedBox(height: 12),
                  Text(
                    provider.errorMessage ?? 'Unable to load products',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchProducts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final allProducts = provider.products;
        final categoryList =
            allProducts.map((p) => mapCategoryLabel(p.category, title: p.title)).toSet().toList()
              ..sort();
        final chips = ['All', ...categoryList];

        final products = _selectedCategory == 'All'
            ? allProducts
            : allProducts
                  .where((product) =>
                      mapCategoryLabel(product.category, title: product.title) == _selectedCategory)
                  .toList();

        return Column(
          children: [
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: chips.map((chipValue) {
                  final chipLabel = chipValue == 'All' ? 'All' : chipValue;
                  final selected = chipValue == _selectedCategory;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(chipLabel),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = chipValue;
                        });
                      },
                      backgroundColor: surfaceContainer,
                      selectedColor: primaryContainer,
                      side: BorderSide(color: selected ? primaryContainer : dividerColor),
                      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: selected ? onPrimaryContainer : textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: false,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, kBottomNavigationBarHeight + 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final Product product = products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => Navigator.of(context).pushNamed('/detail', arguments: product),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
