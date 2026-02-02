
class StockPriceUtils {
  /// Format price dengan currency symbol
  static String formatPrice(double price, {String currency = r'$'}) {
    if (price >= 1000000) {
      return '$currency${(price / 1000000).toStringAsFixed(2)}M';
    } else if (price >= 1000) {
      return '$currency${(price / 1000).toStringAsFixed(2)}K';
    } else if (price < 1) {
      return '$currency${price.toStringAsFixed(6)}';
    } else {
      return '$currency${price.toStringAsFixed(2)}';
    }
  }

  /// Format volume
  static String formatVolume(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(2)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(2)}K';
    } else {
      return volume.toStringAsFixed(4);
    }
  }

  /// Get price change color
  static bool isPriceIncreasing(double currentPrice, double previousPrice) {
    return currentPrice > previousPrice;
  }

  /// Format timestamp to readable time
  static String formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 1) {
      return 'Just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }

  /// Get symbol display name
  static String getSymbolDisplayName(String symbol) {
    final symbolMap = {
      'BTCUSDT': 'Bitcoin',
      'ETHUSDT': 'Ethereum',
      'BNBUSDT': 'Binance Coin',
      'ADAUSDT': 'Cardano',
      'DOGEUSDT': 'Dogecoin',
      'XRPUSDT': 'Ripple',
      'DOTUSDT': 'Polkadot',
      'UNIUSDT': 'Uniswap',
      'LTCUSDT': 'Litecoin',
      'LINKUSDT': 'Chainlink',
    };

    return symbolMap[symbol] ?? symbol;
  }

  /// Get symbol icon/emoji
  static String getSymbolIcon(String symbol) {
    final iconMap = {
      'BTCUSDT': '₿',
      'ETHUSDT': 'Ξ',
      'BNBUSDT': '🟡',
      'ADAUSDT': '🔷',
      'DOGEUSDT': '🐕',
      'XRPUSDT': '💧',
      'DOTUSDT': '🔴',
      'UNIUSDT': '🦄',
      'LTCUSDT': '🥈',
      'LINKUSDT': '🔗',
    };

    return iconMap[symbol] ?? '📈';
  }
}