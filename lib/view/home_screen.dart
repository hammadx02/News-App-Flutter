// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_spinkit/flutter_spinkit.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:intl/intl.dart';
// // import 'package:news_app/models/news_channels_headlines_model.dart';
// // import 'package:news_app/view/categories_screen.dart';
// // import 'package:news_app/view/news_details_screen.dart';
// // import 'package:news_app/view_models/news_view_models.dart';
// // import '../models/categories_news_models.dart';

// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }

// // enum NewsFilterList {
// //   bbcNews,
// //   aryNews,
// //   bbcSports,
// //   alJazeera,
// // }

// // String name = 'bbc-news';

// // class _HomeScreenState extends State<HomeScreen> {
// //   NewsViewModel newsViewModel = NewsViewModel();
// //   final format = DateFormat('MM, dd, yyyy');
// //   NewsFilterList? selectedMenu;
// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.sizeOf(context).height * 1;
// //     final width = MediaQuery.sizeOf(context).width * 1;
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => const CategoriesScreen(),
// //               ),
// //             );
// //           },
// //           icon: Image.asset(
// //             'images/category_icon.png',
// //             height: 20,
// //             width: 20,
// //           ),
// //         ),
// //         title: Text(
// //           'News',
// //           style: GoogleFonts.poppins(
// //             color: Colors.black87,
// //             fontSize: 24,
// //             fontWeight: FontWeight.w700,
// //           ),
// //         ),
// //         centerTitle: true,
// //         actions: [
// //           PopupMenuButton<NewsFilterList>(
// //             initialValue: selectedMenu,
// //             icon: const Icon(
// //               Icons.more_vert_rounded,
// //               color: Colors.black,
// //             ),
// //             onSelected: (NewsFilterList item) {
// //               if (NewsFilterList.bbcNews.name == item.name) {
// //                 name = 'bbc-news';
// //               }
// //               if (NewsFilterList.aryNews.name == item.name) {
// //                 name = 'ary-news';
// //               }
// //               if (NewsFilterList.bbcSports.name == item.name) {
// //                 name = 'bbc-sport';
// //               }
// //               if (NewsFilterList.alJazeera.name == item.name) {
// //                 name = 'al-jazeera-english';
// //               }

// //               setState(() {
// //                 selectedMenu = item;
// //               });
// //             },
// //             itemBuilder: (context) => <PopupMenuEntry<NewsFilterList>>[
// //               const PopupMenuItem<NewsFilterList>(
// //                 value: NewsFilterList.bbcNews,
// //                 child: Text(
// //                   'BBC News',
// //                 ),
// //               ),
// //               const PopupMenuItem<NewsFilterList>(
// //                 value: NewsFilterList.aryNews,
// //                 child: Text(
// //                   'ARY News',
// //                 ),
// //               ),
// //               const PopupMenuItem<NewsFilterList>(
// //                 value: NewsFilterList.bbcSports,
// //                 child: Text(
// //                   'BBC Sports',
// //                 ),
// //               ),
// //               const PopupMenuItem<NewsFilterList>(
// //                 value: NewsFilterList.alJazeera,
// //                 child: Text(
// //                   'Al-Jazeera News',
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //       body: ListView(
// //         children: [
// //           SizedBox(
// //             height: height * 0.55,
// //             width: width,
// //             child: FutureBuilder<NewsChannelsHeadlinesModel>(
// //               future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
// //               builder: (BuildContext context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return const Center(
// //                     child: SpinKitCircle(
// //                       color: Colors.blueAccent,
// //                       size: 50,
// //                     ),
// //                   );
// //                 }
// //                 return ListView.builder(
// //                   itemCount: snapshot.data!.articles!.length,
// //                   scrollDirection: Axis.horizontal,
// //                   itemBuilder: (context, index) {
// //                     DateTime dateTime = DateTime.parse(
// //                       snapshot.data!.articles![index].publishedAt.toString(),
// //                     );
// //                     return InkWell(
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => NewsDetailsScreen(
// //                               newsImage: snapshot
// //                                   .data!.articles![index].urlToImage
// //                                   .toString(),
// //                               newsTitle: snapshot.data!.articles![index].title
// //                                   .toString(),
// //                               newsDate: snapshot
// //                                   .data!.articles![index].publishedAt
// //                                   .toString(),
// //                               newsAuthor: snapshot.data!.articles![index].author
// //                                   .toString(),
// //                               newsDesc: snapshot
// //                                   .data!.articles![index].description
// //                                   .toString(),
// //                               newsContent: snapshot
// //                                   .data!.articles![index].content
// //                                   .toString(),
// //                               newsSource: snapshot
// //                                   .data!.articles![index].source!.name
// //                                   .toString(),
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                       child: SizedBox(
// //                         child: Stack(
// //                           alignment: Alignment.center,
// //                           children: [
// //                             Container(
// //                               height: height * 0.6,
// //                               width: width * 0.9,
// //                               padding: EdgeInsets.symmetric(
// //                                 horizontal: height * 0.02,
// //                               ),
// //                               child: ClipRRect(
// //                                 borderRadius: BorderRadius.circular(15),
// //                                 child: CachedNetworkImage(
// //                                   imageUrl: snapshot
// //                                       .data!.articles![index].urlToImage
// //                                       .toString(),
// //                                   fit: BoxFit.cover,
// //                                   placeholder: (context, url) => Container(
// //                                     child: spinkit2(),
// //                                   ),
// //                                   errorWidget: (context, url, error) =>
// //                                       const Icon(
// //                                     Icons.error_outline_rounded,
// //                                     color: Colors.red,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             Positioned(
// //                               bottom: 20,
// //                               child: Card(
// //                                 elevation: 5,
// //                                 color: Colors.white,
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 child: Container(
// //                                   alignment: Alignment.bottomCenter,
// //                                   padding: const EdgeInsets.all(15),
// //                                   height: height * 0.22,
// //                                   child: Column(
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.center,
// //                                     children: [
// //                                       SizedBox(
// //                                         width: width * 0.7,
// //                                         child: Text(
// //                                           snapshot.data!.articles![index].title
// //                                               .toString(),
// //                                           maxLines: 3,
// //                                           overflow: TextOverflow.ellipsis,
// //                                           style: GoogleFonts.poppins(
// //                                             fontSize: 17,
// //                                             fontWeight: FontWeight.w700,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const Spacer(),
// //                                       SizedBox(
// //                                         width: width * 0.7,
// //                                         child: Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceBetween,
// //                                           children: [
// //                                             Text(
// //                                               snapshot.data!.articles![index]
// //                                                   .source!.name
// //                                                   .toString(),
// //                                               maxLines: 2,
// //                                               overflow: TextOverflow.ellipsis,
// //                                               style: GoogleFonts.poppins(
// //                                                 fontSize: 13,
// //                                                 color: Colors.blueAccent,
// //                                                 fontWeight: FontWeight.w600,
// //                                               ),
// //                                             ),
// //                                             Text(
// //                                               format.format(dateTime),
// //                                               maxLines: 2,
// //                                               overflow: TextOverflow.ellipsis,
// //                                               style: GoogleFonts.poppins(
// //                                                 fontSize: 12,
// //                                                 fontWeight: FontWeight.w500,
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Expanded(
// //             child: Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: FutureBuilder<CategoriesNewsModel>(
// //                 future: newsViewModel.fetchNewsCategoriesApi('General'),
// //                 builder: (BuildContext context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(
// //                       child: SpinKitCircle(
// //                         color: Colors.blueAccent,
// //                         size: 50,
// //                       ),
// //                     );
// //                   }
// //                   return ListView.builder(
// //                     scrollDirection: Axis.vertical,
// //                     shrinkWrap: true,
// //                     itemCount: snapshot.data!.articles!.length,
// //                     itemBuilder: (context, index) {
// //                       DateTime dateTime = DateTime.parse(
// //                         snapshot.data!.articles![index].publishedAt.toString(),
// //                       );
// //                       return Padding(
// //                         padding: const EdgeInsets.only(bottom: 15.0),
// //                         child: InkWell(
// //                           onTap: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => NewsDetailsScreen(
// //                                   newsImage: snapshot
// //                                       .data!.articles![index].urlToImage
// //                                       .toString(),
// //                                   newsTitle: snapshot
// //                                       .data!.articles![index].title
// //                                       .toString(),
// //                                   newsDate: snapshot
// //                                       .data!.articles![index].publishedAt
// //                                       .toString(),
// //                                   newsAuthor: snapshot
// //                                       .data!.articles![index].author
// //                                       .toString(),
// //                                   newsDesc: snapshot
// //                                       .data!.articles![index].description
// //                                       .toString(),
// //                                   newsContent: snapshot
// //                                       .data!.articles![index].content
// //                                       .toString(),
// //                                   newsSource: snapshot
// //                                       .data!.articles![index].source!.name
// //                                       .toString(),
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                           child: Row(
// //                             children: [
// //                               ClipRRect(
// //                                 borderRadius: BorderRadius.circular(15),
// //                                 child: CachedNetworkImage(
// //                                   imageUrl: snapshot
// //                                       .data!.articles![index].urlToImage
// //                                       .toString(),
// //                                   fit: BoxFit.cover,
// //                                   height: height * .18,
// //                                   width: width * .3,
// //                                   placeholder: (context, url) => Container(
// //                                     child: spinkit2(),
// //                                   ),
// //                                   errorWidget: (context, url, error) =>
// //                                       const Icon(
// //                                     Icons.error_outline_rounded,
// //                                     color: Colors.red,
// //                                   ),
// //                                 ),
// //                               ),
// //                               Expanded(
// //                                 child: Container(
// //                                   height: height * .18,
// //                                   padding: const EdgeInsets.only(left: 15),
// //                                   child: Column(
// //                                     children: [
// //                                       Text(
// //                                         snapshot.data!.articles![index].title
// //                                             .toString(),
// //                                         maxLines: 3,
// //                                         style: GoogleFonts.poppins(
// //                                           fontSize: 15,
// //                                           color: Colors.black54,
// //                                           fontWeight: FontWeight.w700,
// //                                         ),
// //                                       ),
// //                                       const Spacer(),
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           Expanded(
// //                                             child: Text(
// //                                               snapshot.data!.articles![index]
// //                                                   .source!.name
// //                                                   .toString(),
// //                                               style: GoogleFonts.poppins(
// //                                                 fontSize: 14,
// //                                                 color: Colors.blueAccent,
// //                                                 fontWeight: FontWeight.w600,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           Text(
// //                                             format.format(dateTime),
// //                                             style: GoogleFonts.poppins(
// //                                               fontSize: 15,
// //                                               color: Colors.black54,
// //                                               fontWeight: FontWeight.w500,
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   SpinKitFadingCircle spinkit2() {
// //     return const SpinKitFadingCircle(
// //       color: Colors.amber,
// //       size: 50,
// //     );
// //   }
// // }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:news_app/models/news_channels_headlines_model.dart';
// import 'package:news_app/view/categories_screen.dart';
// import 'package:news_app/view/news_details_screen.dart';
// import 'package:news_app/view_models/news_view_models.dart';
// import '../models/categories_news_models.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// enum NewsFilterList {
//   bbcNews,
//   aryNews,
//   bbcSports,
//   alJazeera,
// }

// String name = 'bbc-news';

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   NewsViewModel newsViewModel = NewsViewModel();
//   final format = DateFormat('MMM dd, yyyy');
//   NewsFilterList? selectedMenu;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 120,
//               floating: true,
//               pinned: true,
//               backgroundColor: Colors.white,
//               elevation: 0,
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: true,
//                 title: Text(
//                   'News',
//                   style: GoogleFonts.poppins(
//                     color: Colors.black87,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 background: Container(
//                   color: Colors.white,
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           bottom: 16.0, left: 16.0, right: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildSourceTab('BBC', 0),
//                           _buildSourceTab('ARY', 1),
//                           _buildSourceTab('Sports', 2),
//                           _buildSourceTab('Al-Jazeera', 3),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation, secondaryAnimation) =>
//                           const CategoriesScreen(),
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                         return SlideTransition(
//                           position: Tween<Offset>(
//                             begin: const Offset(-1, 0),
//                             end: Offset.zero,
//                           ).animate(animation),
//                           child: child,
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 icon: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.category_outlined,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     // Search functionality
//                   },
//                   icon: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.search,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SliverToBoxAdapter(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildNewsSection('bbc-news'),
//                   _buildNewsSection('ary-news'),
//                   _buildNewsSection('bbc-sport'),
//                   _buildNewsSection('al-jazeera-english'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSourceTab(String title, int index) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           _tabController.animateTo(index);
//           setState(() {
//             switch (index) {
//               case 0:
//                 name = 'bbc-news';
//                 selectedMenu = NewsFilterList.bbcNews;
//                 break;
//               case 1:
//                 name = 'ary-news';
//                 selectedMenu = NewsFilterList.aryNews;
//                 break;
//               case 2:
//                 name = 'bbc-sport';
//                 selectedMenu = NewsFilterList.bbcSports;
//                 break;
//               case 3:
//                 name = 'al-jazeera-english';
//                 selectedMenu = NewsFilterList.alJazeera;
//                 break;
//             }
//           });
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           decoration: BoxDecoration(
//             color:
//                 _tabController.index == index ? Colors.blue : Colors.grey[200],
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Center(
//             child: Text(
//               title,
//               style: GoogleFonts.poppins(
//                 color: _tabController.index == index
//                     ? Colors.white
//                     : Colors.black87,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNewsSection(String newsSource) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Headlines',
//                 style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ).animate().fadeIn(duration: 400.ms).slideX(begin: -30, end: 0),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'See All',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ).animate().fadeIn(duration: 400.ms).slideX(begin: 30, end: 0),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: height * 0.4,
//           child: FutureBuilder<NewsChannelsHeadlinesModel>(
//             future: newsViewModel.fetchNewsChannelsHeadlinesApi(newsSource),
//             builder: (BuildContext context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.blue,
//                   ),
//                 );
//               }
//               if (!snapshot.hasData ||
//                   snapshot.data?.articles == null ||
//                   snapshot.data!.articles!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No headlines available',
//                     style: GoogleFonts.poppins(),
//                   ),
//                 );
//               }
//               return PageView.builder(
//                 controller: PageController(viewportFraction: 0.9),
//                 itemCount: snapshot.data!.articles!.length,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   DateTime dateTime = DateTime.parse(
//                     snapshot.data!.articles![index].publishedAt.toString(),
//                   );
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder:
//                                 (context, animation, secondaryAnimation) =>
//                                     NewsDetailsScreen(
//                               newsImage: snapshot
//                                   .data!.articles![index].urlToImage
//                                   .toString(),
//                               newsTitle: snapshot.data!.articles![index].title
//                                   .toString(),
//                               newsDate: snapshot
//                                   .data!.articles![index].publishedAt
//                                   .toString(),
//                               newsAuthor: snapshot.data!.articles![index].author
//                                   .toString(),
//                               newsDesc: snapshot
//                                   .data!.articles![index].description
//                                   .toString(),
//                               newsContent: snapshot
//                                   .data!.articles![index].content
//                                   .toString(),
//                               newsSource: snapshot
//                                   .data!.articles![index].source!.name
//                                   .toString(),
//                             ),
//                             transitionsBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               return FadeTransition(
//                                 opacity: animation,
//                                 child: child,
//                               );
//                             },
//                           ),
//                         );
//                       },
//                       child: Hero(
//                         tag: "news_${snapshot.data!.articles![index].title}",
//                         child: Card(
//                           elevation: 5,
//                           shadowColor: Colors.black26,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 CachedNetworkImage(
//                                   imageUrl: snapshot
//                                       .data!.articles![index].urlToImage
//                                       .toString(),
//                                   fit: BoxFit.cover,
//                                   placeholder: (context, url) =>
//                                       Center(child: _buildLoadingIndicator()),
//                                   errorWidget: (context, url, error) =>
//                                       Container(
//                                     color: Colors.grey[300],
//                                     child: const Icon(Icons.error_outline,
//                                         color: Colors.red, size: 50),
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                       colors: [
//                                         Colors.transparent,
//                                         Colors.black.withOpacity(0.1),
//                                         Colors.black.withOpacity(0.5),
//                                         Colors.black.withOpacity(0.8),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 0,
//                                   left: 0,
//                                   right: 0,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(16),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8, vertical: 4),
//                                           decoration: BoxDecoration(
//                                             color: Colors.redAccent,
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: Text(
//                                             snapshot.data!.articles![index]
//                                                 .source!.name
//                                                 .toString(),
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           snapshot.data!.articles![index].title
//                                               .toString(),
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: GoogleFonts.poppins(
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           format.format(dateTime),
//                                           style: GoogleFonts.poppins(
//                                             color: Colors.white70,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                       .animate(delay: (index * 100).ms)
//                       .fadeIn(duration: 500.ms)
//                       .slideY(begin: 50, end: 0);
//                 },
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
//           child: Text(
//             'Latest News',
//             style: GoogleFonts.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ).animate().fadeIn(duration: 400.ms).slideX(begin: -30, end: 0),
//         ),
//         SizedBox(
//           height: height * 0.8,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FutureBuilder<CategoriesNewsModel>(
//               future: newsViewModel.fetchNewsCategoriesApi('General'),
//               builder: (BuildContext context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: _buildLoadingIndicator(),
//                   );
//                 }
//                 if (!snapshot.hasData ||
//                     snapshot.data!.articles == null ||
//                     snapshot.data!.articles!.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'No news available',
//                       style: GoogleFonts.poppins(),
//                     ),
//                   );
//                 }
//                 return ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: snapshot.data!.articles!.length,
//                   itemBuilder: (context, index) {
//                     DateTime dateTime = DateTime.parse(
//                       snapshot.data!.articles![index].publishedAt.toString(),
//                     );
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8.0, horizontal: 4.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             PageRouteBuilder(
//                               pageBuilder:
//                                   (context, animation, secondaryAnimation) =>
//                                       NewsDetailsScreen(
//                                 newsImage: snapshot
//                                     .data!.articles![index].urlToImage
//                                     .toString(),
//                                 newsTitle: snapshot.data!.articles![index].title
//                                     .toString(),
//                                 newsDate: snapshot
//                                     .data!.articles![index].publishedAt
//                                     .toString(),
//                                 newsAuthor: snapshot
//                                     .data!.articles![index].author
//                                     .toString(),
//                                 newsDesc: snapshot
//                                     .data!.articles![index].description
//                                     .toString(),
//                                 newsContent: snapshot
//                                     .data!.articles![index].content
//                                     .toString(),
//                                 newsSource: snapshot
//                                     .data!.articles![index].source!.name
//                                     .toString(),
//                               ),
//                               transitionsBuilder: (context, animation,
//                                   secondaryAnimation, child) {
//                                 return FadeTransition(
//                                   opacity: animation,
//                                   child: child,
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         child: Card(
//                           elevation: 3,
//                           shadowColor: Colors.black12,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: CachedNetworkImage(
//                                     imageUrl: snapshot
//                                         .data!.articles![index].urlToImage
//                                         .toString(),
//                                     fit: BoxFit.cover,
//                                     height: 100,
//                                     width: 100,
//                                     placeholder: (context, url) => Container(
//                                       height: 100,
//                                       width: 100,
//                                       color: Colors.grey[200],
//                                       child: const Center(
//                                         child: CircularProgressIndicator(
//                                           color: Colors.blue,
//                                           strokeWidth: 2,
//                                         ),
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         Container(
//                                       height: 100,
//                                       width: 100,
//                                       color: Colors.grey[200],
//                                       child: const Icon(Icons.error_outline,
//                                           color: Colors.red),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         snapshot.data!.articles![index].title
//                                             .toString(),
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             snapshot.data!.articles![index]
//                                                 .source!.name
//                                                 .toString(),
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.blue,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                           Text(
//                                             format.format(dateTime),
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.grey,
//                                               fontSize: 12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                           .animate(delay: (index * 50).ms)
//                           .fadeIn(duration: 300.ms)
//                           .slideX(begin: 50, end: 0),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return const CircularProgressIndicator(
//       color: Colors.blue,
//       strokeWidth: 3,
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_models/news_view_models.dart';
import '../models/categories_news_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsFilterList {
  bbcNews,
  aryNews,
  bbcSports,
  alJazeera,
}

String name = 'bbc-news';

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  NewsFilterList? selectedMenu;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'News',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                background: Container(
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0, left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSourceTab('BBC', 0),
                          _buildSourceTab('ARY', 1),
                          _buildSourceTab('Sports', 2),
                          _buildSourceTab('Al-Jazeera', 3),
                        ],
                      ),
                    ),
                  ),
                ),
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
              ),
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
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.8, // Give the TabBarView a fixed height
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildNewsSection('bbc-news'),
                    _buildNewsSection('ary-news'),
                    _buildNewsSection('bbc-sport'),
                    _buildNewsSection('al-jazeera-english'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
          setState(() {
            switch (index) {
              case 0:
                name = 'bbc-news';
                selectedMenu = NewsFilterList.bbcNews;
                break;
              case 1:
                name = 'ary-news';
                selectedMenu = NewsFilterList.aryNews;
                break;
              case 2:
                name = 'bbc-sport';
                selectedMenu = NewsFilterList.bbcSports;
                break;
              case 3:
                name = 'al-jazeera-english';
                selectedMenu = NewsFilterList.alJazeera;
                break;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                _tabController.index == index ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: _tabController.index == index
                    ? Colors.white
                    : Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsSection(String newsSource) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -30, end: 0),
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
                ).animate().fadeIn(duration: 400.ms).slideX(begin: 30, end: 0),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.4,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(newsSource),
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
                    child: Text(
                      'No headlines available',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: snapshot.data!.articles!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final article = snapshot.data!.articles![index];
                    if (article == null) {
                      return const SizedBox.shrink(); // Skip null articles
                    }
                    DateTime dateTime =
                        DateTime.parse(article.publishedAt ?? '');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      NewsDetailsScreen(
                                newsImage: article.urlToImage ?? '',
                                newsTitle: article.title ?? '',
                                newsDate: article.publishedAt ?? '',
                                newsAuthor: article.author ?? '',
                                newsDesc: article.description ?? '',
                                newsContent: article.content ?? '',
                                newsSource: article.source?.name ?? '',
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Hero(
                          tag: "news_${article.title}",
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.black26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Center(child: _buildLoadingIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.error_outline,
                                          color: Colors.red, size: 50),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.1),
                                          Colors.black.withOpacity(0.5),
                                          Colors.black.withOpacity(0.8),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              article.source?.name ?? '',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            article.title ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
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
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              'Latest News',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -30, end: 0),
          ),
          SizedBox(
            height: height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchNewsCategoriesApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: _buildLoadingIndicator(),
                    );
                  }
                  if (!snapshot.hasData ||
                      snapshot.data!.articles == null ||
                      snapshot.data!.articles!.isEmpty) {
                    return Center(
                      child: Text(
                        'No news available',
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      final article = snapshot.data!.articles![index];
                      if (article == null) {
                        return const SizedBox.shrink(); // Skip null articles
                      }
                      DateTime dateTime =
                          DateTime.parse(article.publishedAt ?? '');
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        NewsDetailsScreen(
                                  newsImage: article.urlToImage ?? '',
                                  newsTitle: article.title ?? '',
                                  newsDate: article.publishedAt ?? '',
                                  newsAuthor: article.author ?? '',
                                  newsDesc: article.description ?? '',
                                  newsContent: article.content ?? '',
                                  newsSource: article.source?.name ?? '',
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shadowColor: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage ?? '',
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                      placeholder: (context, url) => Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.error_outline,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              article.source?.name ?? '',
                                              style: GoogleFonts.poppins(
                                                color: Colors.blue,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator(
      color: Colors.blue,
      strokeWidth: 3,
    );
  }
}
