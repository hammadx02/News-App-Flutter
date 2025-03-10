import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/utils/animations.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view_models/news_view_models.dart';

import '../widgets/headlines_carousel.dart';
import '../widgets/latest_news_list.dart';
import '../widgets/news_source_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  String currentNewsSource = 'bbc-news';
  int _currentNewsSourceIndex = 0;
  final PageController _headlinesPageController =
      PageController(viewportFraction: 0.9);
  final PageController _newsSourcesPageController = PageController();

  final List<Map<String, dynamic>> newsSources = [
    {'name': 'BBC News', 'value': 'bbc-news', 'icon': Icons.public},
    {'name': 'ARY News', 'value': 'ary-news', 'icon': Icons.tv},
    {'name': 'BBC Sports', 'value': 'bbc-sport', 'icon': Icons.sports_soccer},
    {
      'name': 'Al Jazeera',
      'value': 'al-jazeera-english',
      'icon': Icons.language
    },
  ];

  @override
  void dispose() {
    _headlinesPageController.dispose();
    _newsSourcesPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              pinned: true,
              elevation: 0,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'News Today',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ).fadeInSlideUp(delay: 200.ms),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CategoriesScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: Colors.black87,
                  ),
                ),
              ).scaleAnimation(delay: 100.ms),
              actions: [
                IconButton(
                  onPressed: () {
                    // Search functionality
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                  ),
                ).scaleAnimation(delay: 100.ms),
              ],
            ),

            // News Source Selector
            SliverToBoxAdapter(
              child: NewsSourceSelector(
                newsSources: newsSources,
                currentNewsSourceIndex: _currentNewsSourceIndex,
                onSourceSelected: (index) {
                  setState(() {
                    _currentNewsSourceIndex = index;
                    currentNewsSource = newsSources[index]['value'];
                  });
                },
              ).fadeInSlideUp(delay: 300.ms),
            ),

            // Headlines Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Headlines',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ).fadeInSlideLeft(delay: 400.ms),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ).fadeInSlideLeft(delay: 400.ms),
                  ],
                ),
              ),
            ),

            // Headlines Carousel
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: HeadlinesCarousel(
                  currentNewsSource: currentNewsSource,
                  newsViewModel: newsViewModel,
                  format: format,
                ),
              ),
            ),

            // Latest News Section Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Latest News',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ).fadeInSlideLeft(delay: 500.ms),
              ),
            ),

            // Latest News List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              sliver: LatestNewsList(
                newsViewModel: newsViewModel,
                format: format,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
