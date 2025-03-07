// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:news_app/models/categories_news_models.dart';
// import '../view_models/news_view_models.dart';
// import 'news_details_screen.dart';

// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({super.key});

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// String categoryName = 'General';

// List<String> categoriesList = [
//   'General',
//   'Entertainment',
//   'Health',
//   'Sports',
//   'Business',
//   'Technology'
// ];

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   NewsViewModel newsViewModel = NewsViewModel();
//   final format = DateFormat('MM, dd, yyyy');

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width * 1;
//     final height = MediaQuery.sizeOf(context).height * 1;
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
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50,
//               child: ListView.builder(
//                 itemCount: categoriesList.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       categoryName = categoriesList[index];
//                       setState(() {});
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 12),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: categoryName == categoriesList[index]
//                               ? Colors.blueAccent
//                               : Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Center(
//                             child: Text(
//                               categoriesList[index].toString(),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 13,
//                                 color: categoryName == categoriesList[index]
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: FutureBuilder<CategoriesNewsModel>(
//                 future: newsViewModel.fetchNewsCategoriesApi(categoryName),
//                 builder: (BuildContext context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: SpinKitCircle(
//                         color: Colors.blueAccent,
//                         size: 50,
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: snapshot.data!.articles!.length,
//                     itemBuilder: (context, index) {
//                       DateTime dateTime = DateTime.parse(
//                         snapshot.data!.articles![index].publishedAt.toString(),
//                       );
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => NewsDetailsScreen(
//                                   newsImage: snapshot
//                                       .data!.articles![index].urlToImage
//                                       .toString(),
//                                   newsTitle: snapshot
//                                       .data!.articles![index].title
//                                       .toString(),
//                                   newsDate: snapshot
//                                       .data!.articles![index].publishedAt
//                                       .toString(),
//                                   newsAuthor: snapshot
//                                       .data!.articles![index].author
//                                       .toString(),
//                                   newsDesc: snapshot
//                                       .data!.articles![index].description
//                                       .toString(),
//                                   newsContent: snapshot
//                                       .data!.articles![index].content
//                                       .toString(),
//                                   newsSource: snapshot
//                                       .data!.articles![index].source!.name
//                                       .toString(),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(15),
//                                 child: CachedNetworkImage(
//                                   imageUrl: snapshot
//                                       .data!.articles![index].urlToImage
//                                       .toString(),
//                                   fit: BoxFit.cover,
//                                   height: height * .18,
//                                   width: width * .3,
//                                   placeholder: (context, url) => Container(
//                                     child: spinkit2(),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       const Icon(
//                                     Icons.error_outline_rounded,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   height: height * .18,
//                                   padding: const EdgeInsets.only(left: 15),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         snapshot.data!.articles![index].title
//                                             .toString(),
//                                         maxLines: 3,
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 15,
//                                           color: Colors.black54,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                       const Spacer(),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               snapshot.data!.articles![index]
//                                                   .source!.name
//                                                   .toString(),
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                                 color: Colors.blueAccent,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ),
//                                           Text(
//                                             format.format(dateTime),
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 15,
//                                               color: Colors.black54,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   SpinKitFadingCircle spinkit2() {
//     return const SpinKitFadingCircle(
//       color: Colors.amber,
//       size: 50,
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_models.dart';
import '../view_models/news_view_models.dart';
import 'news_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');

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
  void dispose() {
    _pageController.dispose();
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
          ),
          Text(
            'Discover',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ).animate().fadeIn(duration: 400.ms),
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
          bool isSelected = categoryName == categories[index].name;
          return GestureDetector(
            onTap: () {
              setState(() {
                categoryName = categories[index].name;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
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
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : null,
                    ),
                    child: Icon(
                      categories[index].icon,
                      color: isSelected ? Colors.white : Colors.black54,
                      size: 28,
                    ),
                  ),
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
                .animate(delay: (index * 100).ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 30, end: 0),
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
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
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
            ),
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
                onTap: () =>
                    _navigateToNewsDetails(snapshot.data!.articles![index]),
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
                            placeholder: (context, url) => Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
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
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 30, end: 0);
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
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
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
                  .fadeIn(duration: 500.ms)
                  .slideX(begin: 30, end: 0);
            }
          },
        );
      },
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
