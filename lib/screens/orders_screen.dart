import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final VoidCallback onStartShopping;

  const OrdersScreen({super.key, required this.onStartShopping});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF6B35);
    const textSecondary = Color(0xFF8E8E93);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long, size: 54, color: primaryColor),
            const SizedBox(height: 12),
            Text(
              'No orders yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your past orders will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textSecondary),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onStartShopping,
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
