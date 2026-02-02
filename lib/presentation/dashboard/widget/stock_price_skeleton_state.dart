import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart'; 

class StockPriceSkeletonState extends StatelessWidget {

  const StockPriceSkeletonState({
    required this.statusText, super.key,
    this.statusColor = Colors.green,
  });
  final String statusText;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with market summary skeleton
          const Row(
            children: [
              Icon(Icons.trending_up, size: 32, color: Colors.green),
              SizedBox(width: 12),
              Text(
                'Live Market',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '📈 0 📉 0',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '0 symbols',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Skeleton stock items
          ...List.generate(4, (index) => const SkeletonStockItem()),
        ],
      ),
    );
  }
}

class SkeletonStockItem extends StatelessWidget {
  const SkeletonStockItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          // Symbol icon skeleton
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 12),

          // Symbol info skeleton
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bitcoin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.transparent,
                  ),
                ),
                Text(
                  'BTCUSDT',
                  style: TextStyle(fontSize: 12, color: Colors.transparent),
                ),
              ],
            ),
          ),

          // Price and change skeleton
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                r'$99,999.99',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent,
                ),
              ),
              Text(
                '+0.0000',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.transparent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
