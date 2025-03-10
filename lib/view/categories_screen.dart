import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_models.dart';
import 'package:shimmer/shimmer.dart';
import '../view_models/news_view_models.dart';
import 'news_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  late AnimationController _animationController;

  final List<CategoryItem> categories = [
    CategoryItem('General', Icons.public, Colors.blue),
    CategoryItem('Entertainment', Icons.movie, Colors.purple),
    CategoryItem('Health', Icons.health_and_safety, Colors.green),
    CategoryItem('Sports', Icons.sports_basketball, Colors.orange),
    CategoryItem('Business', Icons.business, Colors.indigo),
    CategoryItem('Technology', Icons.computer, Colors.red),
  ];

  String categoryName = 'General';
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategorySelector(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    categoryName = categories[index].name;
                  });
                },
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryContent(categories[index].name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
            ),
          ).animate(autoPlay: true).scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              curve: Curves.elasticOut,
              duration: 600.ms),
          Text(
            'Discover',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          )
              .animate(autoPlay: true)
              .fade(duration: 400.ms)
              .slideY(begin: -10, end: 0, curve: Curves.easeOutQuad),
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
          ).animate(autoPlay: true).scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              curve: Curves.elasticOut,
              duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = categoryName == categories[index].name;
          return GestureDetector(
            onTap: () {
              setState(() {
                categoryName = categories[index].name;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                );
              });

              // Add a small vibration effect on tap
              if (isSelected) return;
              HapticFeedback.lightImpact();
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? categories[index].color
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: categories[index].color.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                                spreadRadius: 2,
                              )
                            ]
                          : null,
                    ),
                    child: Icon(
                      categories[index].icon,
                      color: isSelected ? Colors.white : Colors.black54,
                      size: 28,
                    ),
                  )
                      .animate(target: isSelected ? 1 : 0)
                      .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                          duration: 300.ms)
                      .then()
                      .shake(duration: 400.ms, hz: 3, rotation: 0.02),
                  const SizedBox(height: 8),
                  Text(
                    categories[index].name,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Colors.black87 : Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                .animate(
                    delay: (index * 70).ms, controller: _animationController)
                .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                .slideY(begin: 20, end: 0, curve: Curves.easeOutQuint)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
          );
        },
      ),
    );
  }

  Widget _buildCategoryContent(String category) {
    return FutureBuilder<CategoriesNewsModel>(
      future: newsViewModel.fetchNewsCategoriesApi(category),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        }
        if (!snapshot.hasData ||
            snapshot.data!.articles == null ||
            snapshot.data!.articles!.isEmpty) {
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
            )
                .animate()
                .fade(duration: 500.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.articles!.length,
          itemBuilder: (context, index) {
            DateTime dateTime = DateTime.parse(
              snapshot.data!.articles![index].publishedAt.toString(),
            );

            // Alternate between different card styles
            if (index % 3 == 0) {
              // Featured card (full width)
              return GestureDetector(
                onTap: () {
                  _navigateToNewsDetails(snapshot.data!.articles![index]);
                },
                child: Container(
                  height: 220,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: [
                      Hero(
                        tag: "news_${snapshot.data!.articles![index].title}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data!.articles![index].urlToImage
                                .toString(),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 220,
                            placeholder: (context, url) =>
                                _buildImageShimmer(220),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.error_outline,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(category),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  snapshot.data!.articles![index].source!.name
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                snapshot.data!.articles![index].title
                                    .toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                format.format(dateTime),
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate(delay: (index * 50).ms)
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .slideY(begin: 20, end: 0, curve: Curves.easeOutQuint)
                  .scale(
                      begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
            } else {
              // Standard card
              return GestureDetector(
                onTap: () =>
                    _navigateToNewsDetails(snapshot.data!.articles![index]),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.articles![index].urlToImage
                              .toString(),
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                          placeholder: (context, url) =>
                              _buildImageShimmer(120),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            width: 120,
                            height: 120,
                            child: const Icon(Icons.error_outline,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(category)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  snapshot.data!.articles![index].source!.name
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    color: _getCategoryColor(category),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                snapshot.data!.articles![index].title
                                    .toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                format.format(dateTime),
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate(delay: (index * 50).ms)
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .slideX(begin: 20, end: 0, curve: Curves.easeOutQuint);
            }
          },
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Featured card shimmer
            return Container(
              height: 220,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          } else {
            // Standard card shimmer
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: 100,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildImageShimmer(double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.white,
      ),
    );
  }

  Color _getCategoryColor(String category) {
    for (var item in categories) {
      if (item.name == category) {
        return item.color;
      }
    }
    return Colors.blue; // Default color
  }

  void _navigateToNewsDetails(Articles article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailsScreen(
          newsImage: article.urlToImage.toString(),
          newsTitle: article.title.toString(),
          newsDate:
              format.format(DateTime.parse(article.publishedAt.toString())),
          newsAuthor: article.author.toString(),
          newsDesc: article.description.toString(),
          newsContent: article.content.toString(),
          newsSource: article.source!.name.toString(),
          heroTag: 'news_${article.title}',
        ),
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem(this.name, this.icon, this.color);
}
