import 'dart:async';
import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/domain/entities/stock_price.dart';
import 'package:dynamic_dashboard/utils/stock_price_utils.dart';

@injectable
class StockPriceDataProvider {
  // Latest prices for each symbol
  final Map<String, StockTrade> _latestPrices = <String, StockTrade>{};
  
  // Previous prices for price change calculation
  final Map<String, double> _previousPrices = <String, double>{};
  
  // Price change percentages
  final Map<String, double> _priceChanges = <String, double>{};
  
  // Symbol priorities for sorting/filtering
  final Map<String, int> _symbolPriorities = {
    'BTCUSDT': 1,
    'ETHUSDT': 2,
    'SOLUSDT': 3,
    'XRPUSDT': 4,
  };

  /// Process incoming stock price response and update internal data
  void processStockPriceResponse(StockPriceResponse response) {
    developer.log('Processing ${response.data.length} trades', name: 'StockPriceDataProvider');
    
    for (final trade in response.data) {
      _processTrade(trade);
    }
  }

  /// Process individual trade
  void _processTrade(StockTrade trade) {
    final symbol = trade.formattedSymbol;
    
    // Store previous price for change calculation
    if (_latestPrices.containsKey(symbol)) {
      _previousPrices[symbol] = _latestPrices[symbol]!.p;
      
      // Calculate price change percentage
      final previousPrice = _previousPrices[symbol]!;
      final currentPrice = trade.p;
      final changePercent = ((currentPrice - previousPrice) / previousPrice) * 100;
      _priceChanges[symbol] = changePercent;
    }
    
    // Update latest price
    _latestPrices[symbol] = trade;
    
    developer.log('Updated $symbol: \$${trade.p} (${_priceChanges[symbol]?.toStringAsFixed(2) ?? '0.00'}%)', 
        name: 'StockPriceDataProvider');
  }

  /// Get latest price for a specific symbol
  StockTrade? getLatestPrice(String symbol) {
    return _latestPrices[symbol];
  }

  /// Get all latest prices as unmodifiable map
  Map<String, StockTrade> getAllLatestPrices() {
    return Map.unmodifiable(_latestPrices);
  }

  /// Get price change percentage for a symbol
  double getPriceChange(String symbol) {
    return _priceChanges[symbol] ?? 0.0;
  }

  /// Get all price changes
  Map<String, double> getAllPriceChanges() {
    return Map.unmodifiable(_priceChanges);
  }

  /// Check if price is increasing for a symbol
  bool isPriceIncreasing(String symbol) {
    return getPriceChange(symbol) > 0;
  }

  /// Get symbols sorted by priority
  List<String> getSortedSymbols() {
    final symbols = _latestPrices.keys.toList();
    symbols.sort((a, b) {
      final priorityA = _symbolPriorities[a] ?? 999;
      final priorityB = _symbolPriorities[b] ?? 999;
      return priorityA.compareTo(priorityB);
    });
    return symbols;
  }

  /// Get top performing symbols (by price change)
  List<String> getTopPerformingSymbols({int limit = 5}) {
    final symbols = _priceChanges.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return symbols
        .take(limit)
        .map((entry) => entry.key)
        .toList();
  }

  /// Get symbols filtered by price range
  List<String> getSymbolsByPriceRange({double? minPrice, double? maxPrice}) {
    return _latestPrices.entries
        .where((entry) {
          final price = entry.value.p;
          if (minPrice != null && price < minPrice) return false;
          if (maxPrice != null && price > maxPrice) return false;
          return true;
        })
        .map((entry) => entry.key)
        .toList();
  }

  /// Get formatted price string for a symbol
  String getFormattedPrice(String symbol, {String currency = '\$'}) {
    final trade = getLatestPrice(symbol);
    if (trade == null) return 'N/A';
    return StockPriceUtils.formatPrice(trade.p, currency: currency);
  }

  /// Get formatted volume string for a symbol
  String getFormattedVolume(String symbol) {
    final trade = getLatestPrice(symbol);
    if (trade == null) return 'N/A';
    return StockPriceUtils.formatVolume(trade.v);
  }

  /// Get formatted timestamp for a symbol
  String getFormattedTimestamp(String symbol) {
    final trade = getLatestPrice(symbol);
    if (trade == null) return 'N/A';
    return StockPriceUtils.formatTimestamp(trade.t);
  }

  /// Get display name for a symbol
  String getSymbolDisplayName(String symbol) {
    return StockPriceUtils.getSymbolDisplayName(symbol);
  }

  /// Get symbol icon/emoji
  String getSymbolIcon(String symbol) {
    return StockPriceUtils.getSymbolIcon(symbol);
  }

  /// Get market summary statistics
  MarketSummary getMarketSummary() {
    if (_latestPrices.isEmpty) {
      return const MarketSummary(
        totalSymbols: 0,
        averageChange: 0.0,
        gainers: 0,
        losers: 0,
        unchanged: 0,
      );
    }

    final totalSymbols = _latestPrices.length;
    final changes = _priceChanges.values.toList();
    final averageChange = changes.isEmpty ? 0.0 : changes.reduce((a, b) => a + b) / changes.length;
    
    int gainers = 0;
    int losers = 0;
    int unchanged = 0;
    
    for (final change in changes) {
      if (change > 0) {
        gainers++;
      } else if (change < 0) {
        losers++;
      } else {
        unchanged++;
      }
    }

    return MarketSummary(
      totalSymbols: totalSymbols,
      averageChange: averageChange,
      gainers: gainers,
      losers: losers,
      unchanged: unchanged,
    );
  }

  /// Check if symbol data is stale (older than threshold)
  bool isDataStale(String symbol, {Duration threshold = const Duration(minutes: 5)}) {
    final trade = getLatestPrice(symbol);
    if (trade == null) return true;
    
    final now = DateTime.now();
    final dataTime = trade.dateTime;
    return now.difference(dataTime) > threshold;
  }

  /// Clear all data
  void clearData() {
    developer.log('Clearing all stock price data', name: 'StockPriceDataProvider');
    _latestPrices.clear();
    _previousPrices.clear();
    _priceChanges.clear();
  }

  /// Clear data for specific symbol
  void clearSymbolData(String symbol) {
    _latestPrices.remove(symbol);
    _previousPrices.remove(symbol);
    _priceChanges.remove(symbol);
  }

  /// Get data count
  int get dataCount => _latestPrices.length;

  /// Check if has data for symbol
  bool hasDataForSymbol(String symbol) => _latestPrices.containsKey(symbol);
}

/// Market summary statistics
class MarketSummary {
  final int totalSymbols;
  final double averageChange;
  final int gainers;
  final int losers;
  final int unchanged;

  const MarketSummary({
    required this.totalSymbols,
    required this.averageChange,
    required this.gainers,
    required this.losers,
    required this.unchanged,
  });
}