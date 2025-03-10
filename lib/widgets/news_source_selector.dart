import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsSourceSelector extends StatelessWidget {
  final List<Map<String, dynamic>> newsSources;
  final int currentNewsSourceIndex;
  final Function(int) onSourceSelected;

  const NewsSourceSelector({
    required this.newsSources,
    required this.currentNewsSourceIndex,
    required this.onSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsSources.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final source = newsSources[index];
          final isSelected = currentNewsSourceIndex == index;

          return GestureDetector(
            onTap: () => onSourceSelected(index),
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    source['icon'],
                    size: 28,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    source['name'].toString().split(' ')[0],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
                .animate(target: isSelected ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
                .elevation(begin: 0, end: 8),
          );
        },
      ),
    );
  }
}
