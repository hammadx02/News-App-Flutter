import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:news_app/models/categories_news_models.dart';
import 'package:news_app/view_models/news_view_models.dart';
import 'package:news_app/widgets/category_item.dart';
import 'package:news_app/widgets/featured_news_card.dart';
import 'package:news_app/widgets/standard_news_card.dart';
import 'package:news_app/widgets/shimmer_loading.dart';
import 'package:news_app/widgets/no_articles_found.dart';
import 'package:news_app/widgets/custom_icon_button.dart';
import 'package:news_app/utils/helpers.dart';
import 'package:news_app/utils/animations.dart';
import 'news_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  final NewsViewModel newsViewModel = NewsViewModel();
  final DateFormat format = DateFormat('MMM dd, yyyy');
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
          CustomIconButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Discover',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ).fadeInSlideUp(),
          CustomIconButton(
            icon: Icons.search,
            onPressed: () {
              // Search functionality
            },
          ),
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
          return _buildCategoryItem(index);
        },
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
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
                color: isSelected ? categories[index].color : Colors.grey[200],
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
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.black87 : Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          .animate(delay: (index * 70).ms, controller: _animationController)
          .fadeInSlideUp()
          .scaleAnimation(),
    );
  }

  Widget _buildCategoryContent(String category) {
    return FutureBuilder<CategoriesNewsModel>(
      future: newsViewModel.fetchNewsCategoriesApi(category),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoading();
        }
        if (!snapshot.hasData ||
            snapshot.data!.articles == null ||
            snapshot.data!.articles!.isEmpty) {
          return NoArticlesFound();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.articles!.length,
          itemBuilder: (context, index) {
            final article = snapshot.data!.articles![index];
            final dateTime = DateTime.parse(article.publishedAt.toString());
            final categoryColor = getCategoryColor(category, categories);

            if (index % 3 == 0) {
              return FeaturedNewsCard(
                article: article,
                dateTime: dateTime,
                category: category,
                categoryColor: categoryColor,
                onTap: () => _navigateToNewsDetails(article),
              ).fadeInSlideUp(delay: (index * 50).ms);
            } else {
              return StandardNewsCard(
                article: article,
                dateTime: dateTime,
                category: category,
                categoryColor: categoryColor,
                onTap: () => _navigateToNewsDetails(article),
              ).fadeInSlideLeft(delay: (index * 50).ms);
            }
          },
        );
      },
    );
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
