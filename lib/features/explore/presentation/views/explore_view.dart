import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/mock_news_data.dart';
import '../../../../core/widgets/article_list_tile.dart';
import '../../../../core/widgets/category_chips_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import 'article_detail_view.dart';
import 'search_view.dart';

class ExploreView extends StatefulWidget {
static const String routeName = '/explore';

const ExploreView({super.key});

@override
State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
String _selectedCategory = 'Travel';

final List<String> _categories = [
'Travel',
'Technology',
'Business',
'Entertainment',
'Health',
'Science',
];

final Map<String, String> _mainFeaturedStory = MockNewsData.mainFeaturedStory;
final List<Map<String, String>> _exploreArticles = MockNewsData.exploreArticles;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: SafeArea(
child: Column(
children: [
Container(
padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
color: AppColors.splashBackground,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
  'Explore',
  style: TextStyle(
    fontFamily: 'Lexend_Deca',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  ),
),
IconButton(
  onPressed: () {
    Navigator.of(context).pushNamed(SearchView.routeName);
  },
  icon: const Icon(
    Icons.search_rounded,
    color: AppColors.textPrimary,
    size: 22,
  ),
),
],
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

Expanded(
child: SingleChildScrollView(
physics: const BouncingScrollPhysics(),
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
  GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed(
        ArticleDetailView.routeName,
        arguments: _mainFeaturedStory,
      );
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            _mainFeaturedStory['image']!,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey.shade200,
                child: const Icon(
                    Icons.image_not_supported_rounded),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _mainFeaturedStory['title']!,
          style: const TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                  _mainFeaturedStory['authorAvatar']!),
            ),
            const SizedBox(width: 8),
            Text(
              '${_mainFeaturedStory['author']!} · ${_mainFeaturedStory['date']!}',
              style: const TextStyle(
                fontFamily: 'Lexend_Deca',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    ),
  ),

  const SizedBox(height: 20),

  ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _exploreArticles.length,
    separatorBuilder: (context, index) =>
        const SizedBox(height: 16),
    itemBuilder: (context, index) {
      final article = _exploreArticles[index];
      return ArticleListTile(
        title: article['title']!,
        author: article['author'],
        date: article['date'],
        authorAvatar: article['authorAvatar'],
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
],
),
),
),

const CustomBottomNavBar(activeIndex: 1),
],
),
),
);
}
}
