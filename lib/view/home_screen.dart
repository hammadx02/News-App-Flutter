import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:news_app/view_models/news_view_models.dart';

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
          onPressed: () {},
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
                      color: Colors.blue,
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
                    return SizedBox(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                              color: Colors.blue,
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
                    );
                  },
                );
              },
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
