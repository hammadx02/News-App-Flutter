import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:news_app/view_models/news_view_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

NewsViewModel newsViewModel = NewsViewModel();

class _HomeScreenState extends State<HomeScreen> {
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
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(),
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
                  itemBuilder: (context, index) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
