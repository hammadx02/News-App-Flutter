import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/news_details_app_bar.dart';
import 'package:news_app/widgets/news_details_content.dart';
import 'package:news_app/widgets/news_details_header.dart';
import 'package:news_app/widgets/releated_articles.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: NewsDetailsAppBar(
        showTitle: _showTitle,
        newsTitle: widget.newsTitle,
        onBackPressed: () => Navigator.pop(context),
        onBookmarkPressed: () {
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
        onSharePressed: () {
          // Share functionality
        },
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: NewsDetailsHeader(
                newsImage: widget.newsImage,
                newsTitle: widget.newsTitle,
                newsSource: widget.newsSource,
                newsDate: widget.newsDate,
                newsAuthor: widget.newsAuthor,
                heroTag: widget.heroTag,
                scrollProgress: _scrollProgress,
              ),
            ),
            SliverToBoxAdapter(
              child: NewsDetailsContent(
                newsDesc: widget.newsDesc,
                newsContent: widget.newsContent,
              ),
            ),
            SliverToBoxAdapter(
              child: RelatedArticles(),
            ),
          ],
        ),
      ),
    );
  }
}
