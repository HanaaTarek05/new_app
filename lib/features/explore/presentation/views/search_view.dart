import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/article_list_tile.dart';
import 'search_results_view.dart';

class SearchView extends StatefulWidget {
  static const String routeName = '/search';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<Map<String, String>> _allArticles = [
    {
      'title': "Experience the Serenity of Japan's Traditional Countryside",
      'author': 'Matthew Berge',
      'date': 'Apr 17, 2023',
      'category': 'Travel',
      'image': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=500',
    },
    {
      'title': 'Experience vs. Education: What Matters More in Modern Careers',
      'author': 'Robin Wilkinson',
      'date': 'Apr 20, 2023',
      'category': 'Technology',
      'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=500',
    },
    {
      'title': 'Harnessing the Power of Experience: How to Use Knowledge',
      'author': 'Phillip Paucek',
      'date': 'Apr 29, 2023',
      'category': 'Lifestyle',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
    },
    {
      'title': 'The Role of Experience in Developing Emotional Intelligence',
      'author': 'Gilberto Jacobson',
      'date': 'May 2, 2023',
      'category': 'Science',
      'image': 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=500',
    },
    {
      'title': 'From Failure to Success: How Experience Can Help You Grow',
      'author': 'Faith Smitham',
      'date': 'May 6, 2023',
      'category': 'Business',
      'image': 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=500',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.text = _query;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = _allArticles.where((article) {
      if (_query.trim().isEmpty) return true;
      final q = _query.toLowerCase();
      return article['title']!.toLowerCase().contains(q) ||
          article['category']!.toLowerCase().contains(q) ||
          article['author']!.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryBlue.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(
                          fontFamily: 'Lexend_Deca',
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _query = value;
                          });
                        },
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            Navigator.of(context).pushNamed(
                              SearchResultsView.routeName,
                              arguments: value.trim(),
                            );
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                            size: 20,
                          ),
                          suffixIcon: _query.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _query = '';
                                    });
                                  },
                                )
                              : null,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(
                            fontFamily: 'Lexend_Deca',
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Lexend_Deca',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                physics: const BouncingScrollPhysics(),
                itemCount: searchResults.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final article = searchResults[index];
                  return ArticleListTile(
                    title: article['title']!,
                    author: article['author'],
                    date: article['date'],
                    imageUrl: article['image']!,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        SearchResultsView.routeName,
                        arguments: _query.isEmpty ? article['title'] : _query,
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
