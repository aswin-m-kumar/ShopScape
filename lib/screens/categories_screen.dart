import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/category_mapper.dart';
import '../widgets/product_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFB59D);
    const textPrimary = Color(0xFFFFFFFF);
    const textSecondary = Color(0xFF8E8E93);

    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        if (provider.state == ProductState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }

        if (provider.state == ProductState.error) {
          return Center(
            child: Text(
              provider.errorMessage ?? 'Unable to load categories',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textSecondary),
            ),
          );
        }

        final Map<String, List<Product>> grouped = {};
        for (final product in provider.products) {
          grouped.putIfAbsent(product.category, () => []).add(product);
        }

        final categories = grouped.keys.toList()..sort();

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, kBottomNavigationBarHeight + 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final items = grouped[category] ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatCategoryHeader(category),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 260,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, itemIndex) {
                      final product = items[itemIndex];
                      return SizedBox(
                        width: 170,
                        child: ProductCard(
                          product: product,
                          onTap: () => Navigator.of(context).pushNamed('/detail', arguments: product),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
    );
  }
}
