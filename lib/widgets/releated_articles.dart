import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class RelatedArticles extends StatelessWidget {
  const RelatedArticles();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You May Also Like',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        )
            .animate()
            .fadeIn(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 800))
            .slideY(
                begin: 0.3,
                end: 0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuint),

        const SizedBox(height: 16),

        // Related articles cards with shimmer loading
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 3, // Sample count
            itemBuilder: (context, index) {
              return Container(
                width: width * 0.7,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        period: const Duration(milliseconds: 1500),
                        child: Container(
                          height: 120,
                          width: width * 0.7,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            period: const Duration(milliseconds: 1500),
                            child: Container(
                              height: 16,
                              width: width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            period: const Duration(milliseconds: 1500),
                            child: Container(
                              height: 12,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                      duration: const Duration(milliseconds: 800),
                      delay: Duration(milliseconds: 900 + (index * 100)))
                  .slideX(
                      begin: 0.3,
                      end: 0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuint);
            },
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}
