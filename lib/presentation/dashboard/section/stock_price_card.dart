import 'package:dynamic_dashboard/application/dashboard_action/dashboard_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:dynamic_dashboard/application/stock_price/stock_price_cubit.dart';
import 'package:dynamic_dashboard/injection.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/presentation/dashboard/widget/stock_price_skeleton_state.dart';

class StockPriceCard extends StatefulWidget {
  const StockPriceCard({super.key});

  @override
  State<StockPriceCard> createState() => _StockPriceCardState();
}

class _StockPriceCardState extends State<StockPriceCard>
    with WidgetsBindingObserver {
  late StockPriceCubit _cubit;
  bool _isInBackground = false;

  @override
  void initState() {
    super.initState();
    final dashboardActionCubit = context.read<DashboardActionCubit>();
    _cubit = dashboardActionCubit.state.stockPriceCubit;
    WidgetsBinding.instance.addObserver(this);

    // Start listening when widget is created
    _cubit.startListening();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening and dispose resources when widget is disposed
    _cubit.stopListening();
    _cubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground
        if (_isInBackground) {
          developer.log(
            'App resumed, resuming WebSocket',
            name: 'StockPriceCard',
          );
          _cubit.resumeListening();
          _isInBackground = false;
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // App going to background
        if (!_isInBackground) {
          developer.log(
            'App paused/inactive, pausing WebSocket',
            name: 'StockPriceCard',
          );
          _cubit.pauseListening();
          _isInBackground = true;
        }
        break;
      case AppLifecycleState.detached:
        // App is being terminated
        _cubit.stopListening();
        break;
      case AppLifecycleState.hidden:
        // App is hidden (iOS 13+)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: BlocBuilder<StockPriceCubit, StockPriceState>(
            builder: (context, state) {
              return state.when(
                initial: () => StockPriceSkeletonState(statusText: 'Loading'),
                connecting: () =>
                    StockPriceSkeletonState(statusText: 'Connecting'),
                connected: (latestPrices, connectionState, subscribedSymbols) =>
                    _buildConnectedState(
                      context,
                      latestPrices,
                      subscribedSymbols,
                    ),
                error: (message, latestPrices) =>
                    _buildErrorState(message, context, latestPrices),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildConnectedState(
    BuildContext context,
    Map<String, StockTrade> latestPrices,
    Set<String> subscribedSymbols,
  ) {
    final cubit = context.read<StockPriceCubit>();
    final sortedSymbols = cubit.getSortedSymbols();
    final marketSummary = cubit.getMarketSummary();

    if (latestPrices.isEmpty) {
      return const StockPriceSkeletonState(statusText: 'Waiting');
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with market summary
        Row(
          children: [
            const Icon(Icons.trending_up, size: 32, color: Colors.green),
            const SizedBox(width: 12),
            const Text(
              'Live Market',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '📈 ${marketSummary.gainers} 📉 ${marketSummary.losers}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '${marketSummary.totalSymbols} symbols',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Stock prices list
        ...sortedSymbols
            .map((symbol) => _buildStockItem(cubit, symbol))
            .toList(),
      ],
    );
  }

  Widget _buildStockItem(StockPriceCubit cubit, String symbol) {
    final trade = cubit.getLatestPrice(symbol);
    if (trade == null) return const SizedBox.shrink();

    final priceChange = cubit.getPriceChange(symbol);
    final formattedPrice = cubit.getFormattedPrice(symbol);
    final displayName = cubit.getFormattedPrice(
      symbol,
    ); // This should be display name
    final icon = _getSymbolIcon(symbol);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          // Symbol icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                icon,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.currency_exchange,
                    size: 20,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Symbol info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getSymbolDisplayName(symbol),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  symbol,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Price and change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formattedPrice,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${priceChange >= 0 ? '+' : ''}${priceChange.toStringAsFixed(4)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    String message,
    BuildContext context,
    Map<String, StockTrade>? latestPrices,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        const Text(
          'Market Data Unavailable',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _cubit?.startListening();
          },
          child: const Text('Retry Connection'),
        ),

        // Show last known data if available
        if (latestPrices != null && latestPrices.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Last Known Prices',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ...latestPrices.entries.take(2).map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getSymbolDisplayName(entry.key),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '\$${entry.value.p.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  String _getSymbolIcon(String symbol) {
    const iconMap = {
      'BTCUSDT': 'assets/icon/bitcoin.png',
      'ETHUSDT': 'assets/icon/ethereum.png',
      'SOLUSDT': 'assets/icon/solana.png',
      'XRPUSDT': 'assets/icon/xrp.png',
    };
    return iconMap[symbol] ?? 'assets/icon/default.png';
  }

  String _getSymbolDisplayName(String symbol) {
    const nameMap = {
      'BTCUSDT': 'Bitcoin',
      'ETHUSDT': 'Ethereum',
      'SOLUSDT': 'Solana',
      'XRPUSDT': 'Ripple',
    };
    return nameMap[symbol] ?? symbol;
  }
}
