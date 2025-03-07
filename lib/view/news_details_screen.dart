// // ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers, must_be_immutable
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class NewsDetailsScreen extends StatefulWidget {
//   String newsImage;
//   String newsTitle;
//   String newsDate;
//   String newsAuthor;
//   String newsDesc;
//   String newsContent;
//   String newsSource;

//   NewsDetailsScreen({
//     Key? key,
//     required this.newsImage,
//     required this.newsTitle,
//     required this.newsDate,
//     required this.newsAuthor,
//     required this.newsDesc,
//     required this.newsContent,
//     required this.newsSource,
//   }) : super(key: key);

//   @override
//   State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
// }

// class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
//   final format = DateFormat('MM, dd, yyyy');

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height * 1;
//     final width = MediaQuery.sizeOf(context).width * 1;
//     DateTime dateTime = DateTime.parse(widget.newsDate);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.grey[600],
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             // ignore: sized_box_for_whitespace
//             child: Container(
//               height: height * .45,
//               width: width,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//                 child: CachedNetworkImage(
//                   imageUrl: widget.newsImage,
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => const Center(
//                     child: SpinKitCircle(
//                       color: Colors.blue,
//                       size: 50,
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => const Icon(
//                     Icons.error_outline_rounded,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: height * 0.4),
//             padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
//             height: height * 0.6,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//             ),
//             child: ListView(
//               children: [
//                 Text(
//                   widget.newsTitle,
//                   style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         child: Text(
//                           widget.newsSource,
//                           softWrap: true,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.poppins(
//                             fontSize: 13,
//                             color: Colors.blueAccent,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       format.format(dateTime),
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 Text(
//                   widget.newsDesc,
//                   softWrap: true,
//                   style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 // Text(
//                 //   widget.newsContent,
//                 //   softWrap: true,
//                 //   style: GoogleFonts.poppins(
//                 //     fontSize: 15,
//                 //     color: Colors.black87,
//                 //     fontWeight: FontWeight.w500,
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImage;
  final String newsTitle;
  final String newsDate;
  final String newsAuthor;
  final String newsDesc;
  final String newsContent;
  final String newsSource;

  const NewsDetailsScreen({
    Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.newsAuthor,
    required this.newsDesc,
    required this.newsContent,
    required this.newsSource,
  }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat('MMM dd, yyyy');
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;

    // Calculate scroll progress for parallax effect
    final scrollPosition = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final viewportHeight = _scrollController.position.viewportDimension;

    setState(() {
      _scrollProgress =
          (scrollPosition / (maxScroll + viewportHeight)).clamp(0.0, 1.0);
      _showTitle = scrollPosition > viewportHeight * 0.3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            _showTitle ? Colors.white.withOpacity(0.95) : Colors.transparent,
        elevation: _showTitle ? 2 : 0,
        shadowColor: Colors.black12,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            widget.newsTitle,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _showTitle ? Colors.grey.shade100 : Colors.black26,
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: _showTitle ? Colors.black87 : Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _showTitle ? Colors.grey.shade100 : Colors.black26,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(
                Icons.bookmark_border_rounded,
                color: _showTitle ? Colors.black87 : Colors.white,
                size: 20,
              ),
              onPressed: () {
                // Bookmark functionality
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: _showTitle ? Colors.grey.shade100 : Colors.black26,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(
                Icons.share_rounded,
                color: _showTitle ? Colors.black87 : Colors.white,
                size: 20,
              ),
              onPressed: () {
                // Share functionality
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.45,
              width: width,
              child: Stack(
                children: [
                  // Background image with parallax effect
                  Positioned.fill(
                    child: Transform.scale(
                      scale: 1 + (_scrollProgress * 0.2),
                      child: CachedNetworkImage(
                        imageUrl: widget.newsImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.error_outline_rounded,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Source and date overlay
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.newsSource,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.newsTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              format.format(dateTime),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (widget.newsAuthor != "null" &&
                                widget.newsAuthor.isNotEmpty) ...[
                              const Icon(
                                Icons.person_outline_rounded,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  widget.newsAuthor,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 200))
                        .slideY(
                            begin: 0.2,
                            end: 0,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutQuint),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.newsDesc != "null"
                              ? widget.newsDesc
                              : "No description available",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 400))
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutQuint),

                  const SizedBox(height: 24),

                  // Content
                  Text(
                    'Full Story',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                      .animate()
                      .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 500))
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutQuint),

                  const SizedBox(height: 16),

                  Text(
                    widget.newsContent != "null"
                        ? widget.newsContent
                            .replaceAll(RegExp(r'\[\+\d+ chars\]'), '')
                        : "No content available",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      height: 1.8,
                    ),
                  )
                      .animate()
                      .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 600))
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutQuint),

                  const SizedBox(height: 32),

                  // Related articles section could go here

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
