import 'package:dynamic_dashboard/application/auth/auth_cubit.dart';
import 'package:dynamic_dashboard/application/dashboard_action/dashboard_action_cubit.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';
import 'package:dynamic_dashboard/injection.dart';
import 'package:dynamic_dashboard/presentation/dashboard/section/news_card.dart';
import 'package:dynamic_dashboard/presentation/dashboard/section/stock_price_card.dart';
import 'package:dynamic_dashboard/presentation/dashboard/section/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget _buildCard(String cardType) {
    // Use consistent keys to maintain widget state across rebuilds
    switch (cardType) {
      case 'weather':
        return const WeatherCard(key: PageStorageKey('weather_card'));
      case 'news':
        return const NewsCard(key: PageStorageKey('news_card'));
      case 'stock':
        return const StockPriceCard(key: PageStorageKey('stock_card'));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardActionCubit>()..loadCardOrder(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                unauthenticated: () => context.go('/login'),
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout error: $message')),
                  );
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            backgroundColor: Colors.indigo,
            elevation: 0,
            actions: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    authenticated: (user) => PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'logout') {
                          context.read<AuthCubit>().logout();
                        } else if (value == 'profile') {
                          context.go('/dashboard/profile');
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'profile',
                          child: Row(
                            children: [
                              const Icon(Icons.person, size: 18),
                              const SizedBox(width: 8),
                              Text(user.name),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 18),
                              SizedBox(width: 8),
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(
                            255,
                            162,
                            253,
                            51,
                          ),
                          child: Text(
                            user.name.isNotEmpty
                                ? user.getFirstCharacter()
                                : '?',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    loading: () => const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<DashboardActionCubit, DashboardActionState>(
            builder: (context, state) {
              return ReorderableListView(
                padding: const EdgeInsets.all(16),
                onReorder: (oldIndex, newIndex) {
                  context.read<DashboardActionCubit>().reorderCards(
                    oldIndex,
                    newIndex,
                  );
                },
                children: state.cardOrder.map((cardType) {
                  return Container(
                    key: ValueKey(cardType),
                    // padding: const EdgeInsets.only(bottom: 16),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: _buildCard(cardType),
                        ),
                        // Subtle drag handle - always visible
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),

                            child: const Icon(
                              Icons.drag_handle,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
