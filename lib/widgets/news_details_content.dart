import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsContent extends StatelessWidget {
  final String newsDesc;
  final String newsContent;

  const NewsDetailsContent({
    required this.newsDesc,
    required this.newsContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description card with enhanced design
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Summary',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  newsDesc != "null" ? newsDesc : "No description available",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 500))
              .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),

          const SizedBox(height: 32),

          // Content with enhanced styling
          Row(
            children: [
              Icon(
                Icons.article_outlined,
                color: Colors.blue.shade700,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Full Story',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 600))
              .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),

          const SizedBox(height: 20),

          Text(
            newsContent != "null"
                ? newsContent.replaceAll(RegExp(r'\[\+\d+ chars\]'), '')
                : "No content available",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              height: 1.9,
            ),
          )
              .animate()
              .fadeIn(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 700))
              .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
