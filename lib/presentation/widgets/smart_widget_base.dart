import 'package:flutter/material.dart';

abstract class SmartWidget {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final int gridWidth;
  final int gridHeight;

  const SmartWidget({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    this.gridWidth = 2,
    this.gridHeight = 2,
  });

  Widget build(BuildContext context);
}

class SmartWidgetCard extends StatelessWidget {
  final SmartWidget widget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SmartWidgetCard({
    super.key,
    required this.widget,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.color.withOpacity(0.1),
            widget.color.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: widget.color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: widget.build(context),
          ),
        ),
      ),
    );
  }
}