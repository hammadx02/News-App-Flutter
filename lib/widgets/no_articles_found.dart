import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoArticlesFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No articles found',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
