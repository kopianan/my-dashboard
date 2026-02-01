import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
  
class DashboardPageOld2 extends StatefulWidget {
  const DashboardPageOld2({Key? key}) : super(key: key);

  @override
  State<DashboardPageOld2> createState() => _DashboardPageOld2State();
}

class _DashboardPageOld2State extends State<DashboardPageOld2> {
  List<WidgetItem> widgets = [
    WidgetItem(id: 'weather', type: WidgetType.weather, title: 'Weather'),
    WidgetItem(id: 'stock', type: WidgetType.stock, title: 'Stock Ticker'),
    WidgetItem(id: 'news', type: WidgetType.news, title: 'News Summary'),
  ];

  WeatherData? weatherData;
  List<StockData>? stockData;
  List<NewsData>? newsData;
  
  bool loadingWeather = true;
  bool loadingStock = true;
  bool loadingNews = true;

  Timer? stockTimer;

  @override
  void initState() {
    super.initState();
    fetchWeather();
    fetchStocks();
    fetchNews();
    
    // Auto-refresh stocks every minute
    stockTimer = Timer.periodic(const Duration(minutes: 1), (_) => fetchStocks());
  }

  @override
  void dispose() {
    stockTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchWeather() async {
    setState(() => loadingWeather = true);
    try {
      final response = await http.get(
        Uri.parse('https://wttr.in/Jakarta?format=j1'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherData = WeatherData(
            temp: data['current_condition'][0]['temp_C'],
            condition: data['current_condition'][0]['weatherDesc'][0]['value'],
            humidity: data['current_condition'][0]['humidity'],
            windSpeed: data['current_condition'][0]['windspeedKmph'],
            feelsLike: data['current_condition'][0]['FeelsLikeC'],
            location: 'Jakarta',
          );
        });
      }
    } catch (e) {
      // Fallback data
      setState(() {
        weatherData = WeatherData(
          temp: '28',
          condition: 'Partly Cloudy',
          humidity: '75',
          windSpeed: '12',
          feelsLike: '30',
          location: 'Jakarta',
        );
      });
    } finally {
      setState(() => loadingWeather = false);
    }
  }

  Future<void> fetchStocks() async {
    setState(() => loadingStock = true);
    try {
      // Simulated stock data (replace with real API in production)
      await Future.delayed(const Duration(milliseconds: 500));
      
      setState(() {
        stockData = [
          StockData(
            symbol: 'AAPL',
            price: (150 + (DateTime.now().millisecond % 10)).toDouble(),
            change: (DateTime.now().millisecond % 10 - 5) / 2,
          ),
          StockData(
            symbol: 'GOOGL',
            price: (140 + (DateTime.now().millisecond % 10)).toDouble(),
            change: (DateTime.now().millisecond % 8 - 4) / 2,
          ),
          StockData(
            symbol: 'MSFT',
            price: (380 + (DateTime.now().millisecond % 10)).toDouble(),
            change: (DateTime.now().millisecond % 6 - 3) / 2,
          ),
          StockData(
            symbol: 'TSLA',
            price: (245 + (DateTime.now().millisecond % 10)).toDouble(),
            change: (DateTime.now().millisecond % 12 - 6) / 2,
          ),
        ];
      });
    } catch (e) {
      debugPrint('Stock fetch error: $e');
    } finally {
      setState(() => loadingStock = false);
    }
  }

  Future<void> fetchNews() async {
    setState(() => loadingNews = true);
    try {
      final response = await http.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> storyIds = json.decode(response.body);
        final stories = await Future.wait(
          storyIds.take(5).map((id) async {
            final storyResponse = await http.get(
              Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json'),
            );
            return json.decode(storyResponse.body);
          }),
        );
        
        setState(() {
          newsData = stories.map((story) {
            final timestamp = DateTime.fromMillisecondsSinceEpoch(story['time'] * 1000);
            return NewsData(
              title: story['title'],
              url: story['url'] ?? 'https://news.ycombinator.com/item?id=${story['id']}',
              time: _formatDate(timestamp),
            );
          }).toList();
        });
      }
    } catch (e) {
      // Fallback data
      setState(() {
        newsData = [
          NewsData(title: 'Tech Innovation Reaches New Heights', url: '#', time: 'Today'),
          NewsData(title: 'Global Markets Show Strong Performance', url: '#', time: 'Today'),
          NewsData(title: 'AI Breakthrough Announced', url: '#', time: 'Yesterday'),
        ];
      });
    } finally {
      setState(() => loadingNews = false);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = widgets.removeAt(oldIndex);
      widgets.insert(newIndex, item);
    });
  }

  void _removeWidget(String id) {
    setState(() {
      widgets.removeWhere((w) => w.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f0c29), Color(0xFF302b63), Color(0xFF24243e)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ).createShader(bounds),
                  child: const Text(
                    'Smart Dashboard',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ReorderableListView(
                  padding: const EdgeInsets.all(16),
                  onReorder: _onReorder,
                  children: widgets.map((widget) {
                    return _buildWidget(widget);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(WidgetItem widget) {
    return Container(
      key: ValueKey(widget.id),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.drag_indicator,
                  color: Colors.white.withOpacity(0.4),
                  size: 20,
                ),
                const SizedBox(width: 12),
                _getWidgetIcon(widget.type),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  color: Colors.white.withOpacity(0.6),
                  onPressed: () => _removeWidget(widget.id),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: _getWidgetContent(widget.type),
          ),
        ],
      ),
    );
  }

  Widget _getWidgetIcon(WidgetType type) {
    IconData icon;
    switch (type) {
      case WidgetType.weather:
        icon = Icons.cloud;
        break;
      case WidgetType.stock:
        icon = Icons.trending_up;
        break;
      case WidgetType.news:
        icon = Icons.newspaper;
        break;
    }
    return Icon(icon, color: Colors.white, size: 24);
  }

  Widget _getWidgetContent(WidgetType type) {
    switch (type) {
      case WidgetType.weather:
        return _buildWeatherWidget();
      case WidgetType.stock:
        return _buildStockWidget();
      case WidgetType.news:
        return _buildNewsWidget();
    }
  }

  Widget _buildWeatherWidget() {
    if (loadingWeather) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (weatherData == null) return const SizedBox();

    return Column(
      children: [
        // Main weather info
        Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ).createShader(bounds),
              child: Text(
                '${weatherData!.temp}°C',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              weatherData!.condition,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              weatherData!.location,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Details
        Row(
          children: [
            Expanded(
              child: _buildWeatherDetail('Feels Like', '${weatherData!.feelsLike}°C'),
            ),
            Expanded(
              child: _buildWeatherDetail('Humidity', '${weatherData!.humidity}%'),
            ),
            Expanded(
              child: _buildWeatherDetail('Wind', '${weatherData!.windSpeed} km/h'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Refresh button
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white.withOpacity(0.6),
            onPressed: fetchWeather,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockWidget() {
    if (loadingStock) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (stockData == null) return const SizedBox();

    return Column(
      children: [
        ...stockData!.map((stock) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  stock.symbol,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '\$${stock.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: stock.change >= 0
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${stock.change >= 0 ? '+' : ''}${stock.change.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: stock.change >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white.withOpacity(0.6),
            onPressed: fetchStocks,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsWidget() {
    if (loadingNews) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (newsData == null) return const SizedBox();

    return Column(
      children: [
        ...newsData!.map((news) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                news.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        )).toList(),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white.withOpacity(0.6),
            onPressed: fetchNews,
          ),
        ),
      ],
    );
  }
}

// Data Models
class WidgetItem {
  final String id;
  final WidgetType type;
  final String title;

  WidgetItem({required this.id, required this.type, required this.title});
}

enum WidgetType { weather, stock, news }

class WeatherData {
  final String temp;
  final String condition;
  final String humidity;
  final String windSpeed;
  final String feelsLike;
  final String location;

  WeatherData({
    required this.temp,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.location,
  });
}

class StockData {
  final String symbol;
  final double price;
  final double change;

  StockData({required this.symbol, required this.price, required this.change});
}

class NewsData {
  final String title;
  final String url;
  final String time;

  NewsData({required this.title, required this.url, required this.time});
}