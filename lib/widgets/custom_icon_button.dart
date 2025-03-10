import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.black87,
        ),
      ),
    ).animate(autoPlay: true).scale(
        begin: const Offset(0.5, 0.5),
        end: const Offset(1, 1),
        curve: Curves.elasticOut,
        duration: 600.ms);
  }
}
