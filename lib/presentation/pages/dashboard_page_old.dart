import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_dashboard/application/auth/auth_cubit.dart';

const String _dashboardOrderKey = 'dashboard_order';

class DashboardPageOld extends StatefulWidget {
  const DashboardPageOld({super.key});

  @override
  State<DashboardPageOld> createState() => _DashboardPageOldState();
}

class _DashboardPageOldState extends State<DashboardPageOld> {
  bool isReorderMode = false;
  
  @override
  void initState() {
    super.initState();
    _loadDashboardOrder();
  }
  
  Future<void> _loadDashboardOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final orderJson = prefs.getStringList(_dashboardOrderKey);
      if (orderJson != null && orderJson.isNotEmpty) {
        final orderedItems = <DashboardItem>[];
        for (final id in orderJson) {
          final item = items.firstWhere((item) => item.id == id, orElse: () => items[0]);
          if (!orderedItems.contains(item)) {
            orderedItems.add(item);
          }
        }
        // Add any missing items
        for (final item in items) {
          if (!orderedItems.contains(item)) {
            orderedItems.add(item);
          }
        }
        setState(() {
          items = orderedItems;
        });
      }
    } catch (e) {
      debugPrint('Error loading dashboard order: $e');
    }
  }
  
  Future<void> _saveDashboardOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final orderIds = items.map((item) => item.id).toList();
      await prefs.setStringList(_dashboardOrderKey, orderIds);
    } catch (e) {
      debugPrint('Error saving dashboard order: $e');
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  List<DashboardItem> items = [
    DashboardItem(
      id: '1',
      title: 'Sales',
      value: '\$45,231',
      icon: Icons.shopping_cart,
      color: Colors.blue,
    ),
    DashboardItem(
      id: '2',
      title: 'Users',
      value: '1,234',
      icon: Icons.people,
      color: Colors.green,
    ),
    DashboardItem(
      id: '3',
      title: 'Orders',
      value: '567',
      icon: Icons.receipt_long,
      color: Colors.orange,
    ),
    DashboardItem(
      id: '4',
      title: 'Revenue',
      value: '\$89,421',
      icon: Icons.attach_money,
      color: Colors.purple,
    ),
    DashboardItem(
      id: '5',
      title: 'Products',
      value: '89',
      icon: Icons.inventory,
      color: Colors.red,
    ),
    DashboardItem(
      id: '6',
      title: 'Analytics',
      value: '95%',
      icon: Icons.analytics,
      color: Colors.teal,
    ),
    DashboardItem(
      id: '7',
      title: 'Messages',
      value: '23',
      icon: Icons.message,
      color: Colors.indigo,
    ),
    DashboardItem(
      id: '8',
      title: 'Tasks',
      value: '12',
      icon: Icons.task_alt,
      color: Colors.amber,
    ),
  ];

  List<DashboardItem> tempItems = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () => context.go('/login'),
          error: (message) => context.go('/login'),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Dashboard'),
          elevation: 0,
          actions: [
            if (!isReorderMode)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    isReorderMode = true;
                    tempItems = List.from(items);
                  });
                },
                tooltip: 'Edit Layout',
              ),
            IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isReorderMode)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Drag item untuk menyusun ulang layout',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isReorderMode) const SizedBox(height: 16),
                Expanded(
                  child: isReorderMode
                      ? ReorderableGridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 1,
                              ),
                          itemCount: tempItems.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              final item = tempItems.removeAt(oldIndex);
                              tempItems.insert(newIndex, item);
                            });
                          },
                          itemBuilder: (context, index) {
                            final item = tempItems[index];
                            return DashboardCard(
                              key: ValueKey(item.id),
                              item: item,
                              isShaking: true,
                            );
                          },
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 1,
                              ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return DashboardCard(
                              key: ValueKey(item.id),
                              item: item,
                              isShaking: false,
                            );
                          },
                        ),
                ),
                if (isReorderMode)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                isReorderMode = false;
                                tempItems.clear();
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                items = List.from(tempItems);
                                isReorderMode = false;
                                tempItems.clear();
                              });
                              await _saveDashboardOrder();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Layout berhasil disimpan!'),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatefulWidget {
  final DashboardItem item;
  final bool isShaking;

  const DashboardCard({super.key, required this.item, required this.isShaking});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    if (widget.isShaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(DashboardCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isShaking && !oldWidget.isShaking) {
      _controller.repeat(reverse: true);
    } else if (!widget.isShaking && oldWidget.isShaking) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.isShaking ? _animation.value * 0.01 : 0,
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.item.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.item.icon,
                      color: widget.item.color,
                      size: 24,
                    ),
                  ),
                  if (widget.isShaking)
                    Icon(
                      Icons.drag_indicator,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final String id;
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  DashboardItem({
    required this.id,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}
