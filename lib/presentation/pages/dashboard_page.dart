import 'package:flutter/material.dart';
import 'package:dynamic_dashboard/presentation/widgets/weather_card.dart';
import 'package:dynamic_dashboard/presentation/widgets/news_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Weather Card
            WeatherCard(),

            SizedBox(height: 16),

            // News Card
            NewsCard(),

            // TODO: Add Stock Price Ticker Card here later
            // StockPriceCard(),
          ],
        ),
      ),
    );
  }
}
