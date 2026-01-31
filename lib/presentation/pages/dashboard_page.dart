import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_dashboard/presentation/widgets/weather_card.dart';
import 'package:dynamic_dashboard/presentation/widgets/news_card.dart';
import 'package:dynamic_dashboard/presentation/widgets/stock_price_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const String _cardOrderKey = 'dashboard_card_order';
  static const List<String> _defaultOrder = ['weather', 'news', 'stock'];
  
  List<String> _cardOrder = _defaultOrder;
  
  @override
  void initState() {
    super.initState();
    _loadCardOrder();
  }
  
  Future<void> _loadCardOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList(_cardOrderKey);
    if (savedOrder != null && savedOrder.isNotEmpty) {
      setState(() {
        _cardOrder = savedOrder;
      });
    }
  }
  
  Future<void> _saveCardOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_cardOrderKey, _cardOrder);
  }
  
  Widget _buildCard(String cardType) {
    // Use consistent keys to maintain widget state across rebuilds
    switch (cardType) {
      case 'weather':
        return WeatherCard(key: const PageStorageKey('weather_card'));
      case 'news':
        return NewsCard(key: const PageStorageKey('news_card'));
      case 'stock':
        return StockPriceCard(key: const PageStorageKey('stock_card'));
      default:
        return const SizedBox.shrink();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(16),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = _cardOrder.removeAt(oldIndex);
            _cardOrder.insert(newIndex, item);
          });
          _saveCardOrder(); // Auto-save on reorder
        },
        children: _cardOrder.map((cardType) {
          return Container(
            key: ValueKey(cardType),
            margin: const EdgeInsets.only(bottom: 16),
            child: Stack(
              children: [
                _buildCard(cardType),
                // Subtle drag handle - always visible
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.drag_handle,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildNormalView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _cardOrder.map((cardType) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildCard(cardType),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildReorderableView() {
    return ReorderableListView(
      padding: const EdgeInsets.all(16),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = _cardOrder.removeAt(oldIndex);
          _cardOrder.insert(newIndex, item);
        });
      },
      children: _cardOrder.map((cardType) {
        return Container(
          key: ValueKey(cardType),
          margin: const EdgeInsets.only(bottom: 16),
          child: Stack(
            children: [
              _buildCard(cardType),
              // Drag handle
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.drag_handle,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
