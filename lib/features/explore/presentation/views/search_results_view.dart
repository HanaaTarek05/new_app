import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/article_list_tile.dart';
import '../../../../core/widgets/category_chips_bar.dart';
import 'article_detail_view.dart';

class SearchResultsView extends StatefulWidget {
static const String routeName = '/search-results';

const SearchResultsView({super.key});

@override
State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
late TextEditingController _searchController;
String _currentQuery = '';
String _selectedCategory = 'All';

final List<Map<String, String>> _allArticlesDatabase = [
{
'title': "Experience the Serenity of Japan's Traditional Countryside",
'author': 'Matthew Berge',
'date': 'Apr 17, 2023',
'category': 'Travel',
'authorAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
'image': 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=500',
},
{
'title': 'Experience vs. Education: What Matters More in Modern Careers',
'author': 'Robin Wilkinson',
'date': 'Apr 20, 2023',
'category': 'Technology',
'authorAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400',
},
{
'title': 'Uncovering the Hidden Gems of the Amazon Forest',
'author': 'Ms. Lana Kub',
'date': 'May 1, 2023',
'category': 'Travel',
'authorAvatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
'image': 'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=500',
},
{
'title': 'Harnessing the Power of Experience: How to Use Knowledge',
'author': 'Phillip Paucek',
'date': 'Apr 29, 2023',
'category': 'Lifestyle',
'authorAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
},
{
'title': 'The Role of Experience in Developing Emotional Intelligence',
'author': 'Gilberto Jacobson',
'date': 'May 2, 2023',
'category': 'Science',
'authorAvatar': 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=100',
'image': 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=400',
},
{
'title': 'A Journey Through Time: Discovering the Nile river',
'author': 'Maliaea White',
'date': 'May 7, 2023',
'category': 'Travel',
'authorAvatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
'image': 'https://images.unsplash.com/photo-1539650116574-8efeb43e2750?w=400',
},
{
'title': 'Chasing the Northern Lights: A Winter in Finland',
'author': 'Jeannie Conn',
'date': 'May 12, 2023',
'category': 'Travel',
'authorAvatar': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100',
'image': 'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=400',
},
{
'title': 'From Failure to Success: How Experience Can Help You Grow',
'author': 'Faith Smitham',
'date': 'May 6, 2023',
'category': 'Business',
'authorAvatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
'image': 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=400',
},
{
'title': 'Exploring Future Technology and Smart Architecture',
'author': 'David Miller',
'date': 'May 5, 2023',
'category': 'Technology',
'authorAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
'image': 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=500',
},
{
'title': 'Artificial Intelligence in Modern Business & Creativity',
'author': 'David Chen',
'date': 'May 8, 2023',
'category': 'Innovation',
'authorAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
'image': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500',
},
{
'title': 'The Benefits of Multidisciplinary Learning & Experience',
'author': 'Sophie Larkin',
'date': 'May 10, 2023',
'category': 'Technology',
'authorAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
'image': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400',
},
{
'title': 'Experience and Creativity: Exploring the Connection',
'author': "Glenn O'Conner",
'date': 'May 13, 2023',
'category': 'Travel',
'authorAvatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
'image': 'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=400',
},
];

@override
void initState() {
super.initState();
_searchController = TextEditingController();
}

@override
void didChangeDependencies() {
super.didChangeDependencies();
final args = ModalRoute.of(context)?.settings.arguments;
if (args is String && _currentQuery.isEmpty) {
_currentQuery = args;
_searchController.text = args;
}
}

@override
void dispose() {
_searchController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
final queryMatches = _allArticlesDatabase.where((article) {
if (_currentQuery.trim().isEmpty) return true;
final q = _currentQuery.toLowerCase();
final title = article['title']!.toLowerCase();
final category = article['category']!.toLowerCase();
final author = article['author']!.toLowerCase();

final queryWords = q.split(' ');
return queryWords.any((word) =>
title.contains(word) ||
category.contains(word) ||
author.contains(word));
}).toList();

final Map<String, int> categoryCounts = {'All': queryMatches.length};
for (var article in queryMatches) {
final cat = article['category']!;
categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;
}

final categoriesList = ['All', ...categoryCounts.keys.where((k) => k != 'All')];

// 3. Filter by selected category chip
final finalDisplayList = queryMatches.where((article) {
if (_selectedCategory == 'All') return true;
return article['category'] == _selectedCategory;
}).toList();

return Scaffold(
backgroundColor: Colors.white,
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
leading: IconButton(
icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
onPressed: () => Navigator.of(context).pop(),
),
title: const Text(
'Search results',
style: TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 18,
fontWeight: FontWeight.bold,
color: AppColors.textPrimary,
),
),
centerTitle: false,
),
body: SafeArea(
child: Column(
children: [
// Top Live Search Bar Input
Padding(
padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
child: Container(
height: 44,
decoration: BoxDecoration(
color: const Color(0xFFF2F3F7),
borderRadius: BorderRadius.circular(24),
border: Border.all(
  color: AppColors.primaryBlue.withValues(alpha: 0.3),
  width: 1,
),
),
child: TextField(
controller: _searchController,
style: const TextStyle(
  fontFamily: 'Lexend_Deca',
  fontSize: 14,
  color: AppColors.textPrimary,
),
onChanged: (val) {
  setState(() {
    _currentQuery = val;
    _selectedCategory = 'All';
  });
},
decoration: InputDecoration(
  prefixIcon: const Icon(Icons.search_rounded,
      color: Colors.grey, size: 20),
  suffixIcon: _currentQuery.isNotEmpty
      ? IconButton(
          icon: const Icon(Icons.cancel,
              color: Colors.grey, size: 18),
          onPressed: () {
            setState(() {
              _searchController.clear();
              _currentQuery = '';
              _selectedCategory = 'All';
            });
          },
        )
      : null,
  hintText: 'Search topic, title or category...',
  hintStyle: const TextStyle(
    fontFamily: 'Lexend_Deca',
    fontSize: 14,
    color: Colors.grey,
  ),
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(vertical: 10),
),
),
),
),

CategoryChipsBar(
categories: categoriesList,
selectedCategory: _selectedCategory,
categoryCounts: categoryCounts,
onCategorySelected: (catName) {
setState(() {
_selectedCategory = catName;
});
},
),

const SizedBox(height: 12),

Expanded(
child: finalDisplayList.isEmpty
? Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.search_off_rounded,
            size: 48, color: Colors.grey),
        const SizedBox(height: 12),
        Text(
          'No results found for "$_currentQuery"',
          style: const TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 15,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  )
: ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    physics: const BouncingScrollPhysics(),
    itemCount: finalDisplayList.length,
    separatorBuilder: (context, index) =>
        const SizedBox(height: 16),
    itemBuilder: (context, index) {
      final article = finalDisplayList[index];
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
),
],
),
),
);
}
}
