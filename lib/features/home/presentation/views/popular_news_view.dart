import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/article_list_tile.dart';
import '../../../../core/widgets/category_chips_bar.dart';
import '../../../explore/presentation/views/article_detail_view.dart';

class PopularNewsView extends StatefulWidget {
  static const String routeName = '/popular-news';

  const PopularNewsView({super.key});

  @override
  State<PopularNewsView> createState() => _PopularNewsViewState();
}

class _PopularNewsViewState extends State<PopularNewsView> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Technology',
    'Travel',
    'Innovation',
    'Environment',
    'Lifestyle',
    'Economy',
  ];

  final List<Map<String, String>> _allArticles = [
    {
      'title': 'The Pros and Cons of Remote Work',
      'category': 'Technology',
      'author': 'Alex Johnson',
      'date': 'May 5, 2023',
      'image': 'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?w=500',
    },
    {
      'title': 'Top 10 Nature Escapes for Outdoor Enthusiasts',
      'category': 'Travel',
      'author': 'Sarah Miller',
      'date': 'May 7, 2023',
      'image': 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=500',
    },
    {
      'title': 'Artificial Intelligence in Modern Business & Creativity',
      'category': 'Innovation',
      'author': 'David Chen',
      'date': 'May 8, 2023',
      'image': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500',
    },
    {
      'title': 'The Future of Clean Renewable Energy Solutions',
      'category': 'Environment',
      'author': 'Emma Watson',
      'date': 'May 10, 2023',
      'image': 'https://images.unsplash.com/photo-1466611653911-95081537e5b7?w=500',
    },
    {
      'title': 'Mindfulness & Peak Productivity Strategies',
      'category': 'Lifestyle',
      'author': 'Michael Brown',
      'date': 'May 12, 2023',
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500',
    },
    {
      'title': 'Global Financial Trends and Digital Economy Shifts',
      'category': 'Economy',
      'author': 'Sophia Taylor',
      'date': 'May 14, 2023',
      'image': 'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredArticles = _allArticles.where((article) {
      final matchesCategory = _selectedCategory == 'All' ||
          article['category'] == _selectedCategory;
      final matchesSearch = article['title']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          article['category']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Most Popular News',
          style: TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search articles, topics...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Lexend_Deca',
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.splashBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            CategoryChipsBar(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: filteredArticles.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search_off_rounded,
                              size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'No articles found',
                            style: TextStyle(
                              fontFamily: 'Lexend_Deca',
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredArticles.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final article = filteredArticles[index];
                        return ArticleListTile(
                          title: article['title']!,
                          category: article['category'],
                          author: article['author'],
                          date: article['date'],
                          imageUrl: article['image']!,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ArticleDetailView.routeName,
                              arguments: article,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
