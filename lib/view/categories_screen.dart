import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../view_models/news_view_models.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

String categoryName = 'General';

List<String> categoriesList = [
  'General',
  'Entertainment',
  'Health',
  'Sports',
  'Business',
  'Technology'
];

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM, dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: categoriesList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    categoryName = categoriesList[index];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: categoryName == categoriesList[index]
                            ? Colors.blue
                            : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(categoriesList[index].toString(),   style: GoogleFonts.poppins(fontSize: 13,color: categoryName == categoriesList[index] ? Colors.white : Colors.black,),),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
