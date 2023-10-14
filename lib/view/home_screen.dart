import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM, dd, yyyy');
  NewsFilterList? selectedMenu;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoriesScreen(),
              ),
            );
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<NewsFilterList>(
            initialValue: selectedMenu,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.black,
            ),
            onSelected: (NewsFilterList item) {
              if (NewsFilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (NewsFilterList.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (NewsFilterList.bbcSports.name == item.name) {
                name = 'bbc-sport';
              }
              if (NewsFilterList.alJazeera.name == item.name) {
                name = 'al-jazeera-english';
              }

              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<NewsFilterList>>[
              const PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.bbcNews,
                child: Text(
                  'BBC News',
                ),
              ),
              const PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.aryNews,
                child: Text(
                  'ARY News',
                ),
              ),
              const PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.bbcSports,
                child: Text(
                  'BBC Sports',
                ),
              ),
              const PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.alJazeera,
                child: Text(
                  'Al-Jazeera News',
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blueAccent,
                      size: 50,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString(),
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailsScreen(
                              newsImage: snapshot
                                  .data!.articles![index].urlToImage
                                  .toString(),
                              newsTitle: snapshot.data!.articles![index].title
                                  .toString(),
                              newsDate: snapshot
                                  .data!.articles![index].publishedAt
                                  .toString(),
                              newsAuthor: snapshot.data!.articles![index].author
                                  .toString(),
                              newsDesc: snapshot
                                  .data!.articles![index].description
                                  .toString(),
                              newsContent: snapshot
                                  .data!.articles![index].content
                                  .toString(),
                              newsSource: snapshot
                                  .data!.articles![index].source!.name
                                  .toString(),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: width * 0.9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * 0.02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinkit2(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.all(15),
                                  height: height * 0.22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchNewsCategoriesApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.blueAccent,
                        size: 50,
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => Container(
                                  child: spinkit2(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * .18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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

  SpinKitFadingCircle spinkit2() {
    return const SpinKitFadingCircle(
      color: Colors.amber,
      size: 50,
    );
  }
}
