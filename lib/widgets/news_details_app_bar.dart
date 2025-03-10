import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showTitle;
  final String newsTitle;
  final VoidCallback onBackPressed;
  final VoidCallback onBookmarkPressed;
  final VoidCallback onSharePressed;

  const NewsDetailsAppBar({
    required this.showTitle,
    required this.newsTitle,
    required this.onBackPressed,
    required this.onBookmarkPressed,
    required this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: showTitle
          ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98)
          : Colors.transparent,
      elevation: showTitle ? 1 : 0,
      shadowColor: Colors.black12,
      title: AnimatedOpacity(
        opacity: showTitle ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Text(
          newsTitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: showTitle
              ? Colors.grey.shade100
              : Colors.black38.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: showTitle
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: showTitle ? Colors.black87 : Colors.white,
            size: 20,
          ),
          onPressed: onBackPressed,
        ),
      ),
      actions: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: showTitle
                ? Colors.grey.shade100
                : Colors.black38.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: showTitle
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: IconButton(
            icon: Icon(
              Icons.bookmark_border_rounded,
              color: showTitle ? Colors.black87 : Colors.white,
              size: 20,
            ),
            onPressed: onBookmarkPressed,
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: showTitle
                ? Colors.grey.shade100
                : Colors.black38.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: showTitle
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: IconButton(
            icon: Icon(
              Icons.share_rounded,
              color: showTitle ? Colors.black87 : Colors.white,
              size: 20,
            ),
            onPressed: onSharePressed,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
