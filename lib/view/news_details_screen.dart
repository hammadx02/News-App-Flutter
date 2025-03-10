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
  final String heroTag;

  const NewsDetailsScreen({
    Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.newsAuthor,
    required this.newsDesc,
    required this.newsContent,
    required this.newsSource,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen>
    with SingleTickerProviderStateMixin {
  final format = DateFormat('MMM dd, yyyy');
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;
  bool _showTitle = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
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
      _showTitle = scrollPosition > viewportHeight * 0.25;
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
        backgroundColor: _showTitle
            ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98)
            : Colors.transparent,
        elevation: _showTitle ? 1 : 0,
        shadowColor: Colors.black12,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
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
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _showTitle
                ? Colors.grey.shade100
                : Colors.black38.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _showTitle
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _showTitle
                  ? Colors.grey.shade100
                  : Colors.black38.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              boxShadow: _showTitle
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
            ),
            child: IconButton(
              icon: Icon(
                Icons.bookmark_border_rounded,
                color: _showTitle ? Colors.black87 : Colors.white,
                size: 20,
              ),
              onPressed: () {
                // Bookmark functionality with animation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Article saved to bookmarks',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.blue.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: _showTitle
                  ? Colors.grey.shade100
                  : Colors.black38.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              boxShadow: _showTitle
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.5,
                width: width,
                child: Stack(
                  children: [
                    // Background image with Hero animation and parallax effect
                    Positioned.fill(
                      child: Hero(
                        tag: widget.heroTag,
                        child: Transform.scale(
                          scale: 1 + (_scrollProgress * 0.3),
                          child: CachedNetworkImage(
                            imageUrl: widget.newsImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              period: const Duration(milliseconds: 1200),
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: Center(
                                child: Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.red.shade400,
                                  size: 50,
                                ).animate().shake(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Enhanced gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.9),
                            ],
                            stops: const [0.0, 0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Source and date overlay with enhanced animations
                    Positioned(
                      bottom: 24,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade800.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              widget.newsSource,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.newsTitle,
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      format.format(dateTime),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (widget.newsAuthor != "null" &&
                                  widget.newsAuthor.isNotEmpty)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.person_outline_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            widget.newsAuthor,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 300))
                          .slideY(
                              begin: 0.3,
                              end: 0,
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutQuint),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
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
                            widget.newsDesc != "null"
                                ? widget.newsDesc
                                : "No description available",
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
                      widget.newsContent != "null"
                          ? widget.newsContent
                              .replaceAll(RegExp(r'\[\+\d+ chars\]'), '')
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

                    // Related articles section
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        period:
                                            const Duration(milliseconds: 1500),
                                        child: Container(
                                          height: 16,
                                          width: width * 0.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        period:
                                            const Duration(milliseconds: 1500),
                                        child: Container(
                                          height: 12,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                  delay: Duration(
                                      milliseconds: 900 + (index * 100)))
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
