import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ArticleDetailView extends StatefulWidget {
static const String routeName = '/article-detail';

const ArticleDetailView({super.key});

@override
State<ArticleDetailView> createState() => _ArticleDetailViewState();
}

class _ArticleDetailViewState extends State<ArticleDetailView> {
bool _isBookmarked = false;

@override
Widget build(BuildContext context) {
final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

final String title = args?['title'] ?? 'See How the Forest is Helping Our World';
final String author = args?['author'] ?? 'Harry Harper';
final String date = args?['date'] ?? 'Apr 12, 2023';
final String authorAvatar = args?['authorAvatar'] ??
'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100';
final String imageUrl = args?['image'] ??
'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800';

return Scaffold(
backgroundColor: Colors.white,
body: SingleChildScrollView(
physics: const BouncingScrollPhysics(),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox(
  height: MediaQuery.of(context).size.height * 0.38,
  width: double.infinity,
  child: Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade300,
            child: const Icon(
              Icons.image_not_supported_rounded,
              size: 48,
              color: Colors.grey,
            ),
          );
        },
      ),
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black45,
              Colors.transparent,
            ],
          ),
        ),
      ),
    ],
  ),
),

Transform.translate(
  offset: const Offset(0, -20),
  child: Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textPrimary,
                size: 24,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: _isBookmarked
                        ? AppColors.primaryBlue
                        : AppColors.textPrimary,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBookmarked = !_isBookmarked;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isBookmarked
                            ? 'Article saved to bookmarks'
                            : 'Article removed from bookmarks'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.ios_share_rounded,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sharing article link...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(authorAvatar),
            ),
            const SizedBox(width: 8),
            Text(
              '$author · $date',
              style: const TextStyle(
                fontFamily: 'Lexend_Deca',
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          'Forests are one of the most important natural resources that our planet possesses. Not only do they provide us with a diverse range of products such as timber, medicine, and food, but they also play a vital role in mitigating climate change and maintaining the overall health of our planet\'s ecosystems. In this article, we will explore the ways in which forests are helping our world.',
          style: TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 14,
            color: Color(0xFF4A4A4A),
            height: 1.6,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'One of the most important roles that forests play is in absorbing carbon dioxide from the atmosphere. Trees absorb carbon dioxide through photosynthesis and store it in their trunks, branches, and leaves. This carbon storage helps reduce greenhouse gases and stabilizes global temperature levels.',
          style: TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 14,
            color: Color(0xFF4A4A4A),
            height: 1.6,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'Furthermore, forests act as habitats for millions of species of plants, animals, and insects, safeguarding global biodiversity for future generations.',
          style: TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 14,
            color: Color(0xFF4A4A4A),
            height: 1.6,
          ),
        ),
      ],
    ),
  ),
),
],
),
),
);
}
}
