import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/data/mock_news_data.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../explore/presentation/views/article_detail_view.dart';
import 'popular_news_view.dart';

class HomeView extends StatefulWidget {
static const String routeName = '/home';

const HomeView({super.key});

@override
State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
int _currentSlide = 0;

final PageController _pageController = PageController();
final ScrollController _popularScrollController = ScrollController();

final List<Map<String, String>> _featuredNews = MockNewsData.featuredNews;
final List<Map<String, String>> _popularNews = MockNewsData.popularNews;

@override
void dispose() {
_pageController.dispose();
_popularScrollController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: SafeArea(
child: Column(
children: [
const CustomAppHeader(),

Expanded(
child: Padding(
padding: const EdgeInsets.symmetric(vertical: 12),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox(
height: 200,
child: PageView.builder(
controller: _pageController,
physics: const BouncingScrollPhysics(),
onPageChanged: (index) {
setState(() {
_currentSlide = index;
});
},
itemCount: _featuredNews.length,
itemBuilder: (context, index) {
final item = _featuredNews[index];
return GestureDetector(
onTap: () {
Navigator.of(context).pushNamed(
ArticleDetailView.routeName,
arguments: item,
);
},
child: Container(
margin: const EdgeInsets.symmetric(horizontal: 20),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
image: DecorationImage(
image: NetworkImage(item['image']!),
fit: BoxFit.cover,
),
boxShadow: const [
BoxShadow(
color: Colors.black12,
blurRadius: 10,
offset: Offset(0, 4),
),
],
),
child: Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Colors.transparent,
Colors.black.withValues(alpha: 0.8),
],
),
),
padding: const EdgeInsets.all(16),
child: Column(
mainAxisAlignment: MainAxisAlignment.end,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
  Expanded(
    child: Text(
      item['title']!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: 'Lexend_Deca',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.3,
      ),
    ),
  ),
  const SizedBox(width: 8),
  Text(
    item['author']!,
    style: TextStyle(
      fontFamily: 'Lexend_Deca',
      fontSize: 12,
      color: Colors.white.withValues(alpha: 0.85),
    ),
  ),
],
),
],
),
),
),
);
},
),
),

const SizedBox(height: 10),

Row(
mainAxisAlignment: MainAxisAlignment.center,
children: List.generate(_featuredNews.length, (index) {
return AnimatedContainer(
duration: const Duration(milliseconds: 300),
margin: const EdgeInsets.symmetric(horizontal: 3),
width: _currentSlide == index ? 16 : 6,
height: 6,
decoration: BoxDecoration(
color: _currentSlide == index
? AppColors.primaryBlue
: Colors.grey.shade300,
borderRadius: BorderRadius.circular(3),
),
);
}),
),

const SizedBox(height: 20),

Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Most Popular',
style: TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 18,
fontWeight: FontWeight.bold,
color: AppColors.textPrimary,
),
),
GestureDetector(
onTap: () {
Navigator.of(context)
.pushNamed(PopularNewsView.routeName);
},
child: const Text(
'See More',
style: TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 13,
fontWeight: FontWeight.w600,
color: AppColors.primaryBlue,
),
),
),
],
),
),

const SizedBox(height: 14),

Expanded(
child: ListView.separated(
controller: _popularScrollController,
padding: const EdgeInsets.symmetric(horizontal: 20),
scrollDirection: Axis.horizontal,
physics: const BouncingScrollPhysics(),
itemCount: _popularNews.length,
separatorBuilder: (context, index) =>
const SizedBox(width: 16),
itemBuilder: (context, index) {
final item = _popularNews[index];
return GestureDetector(
onTap: () {
Navigator.of(context).pushNamed(
ArticleDetailView.routeName,
arguments: item,
);
},
child: SizedBox(
width: 200,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: ClipRRect(
borderRadius: BorderRadius.circular(14),
child: Image.network(
  item['image']!,
  width: 200,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: 200,
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.image_not_supported_rounded,
        color: Colors.grey,
      ),
    );
  },
),
),
),
const SizedBox(height: 8),
Text(
item['title']!,
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 13,
fontWeight: FontWeight.bold,
color: AppColors.textPrimary,
height: 1.2,
),
),
const SizedBox(height: 3),
Text(
item['category']!,
style: const TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 11,
color: AppColors.textSecondary,
),
),
],
),
),
);
},
),
),
],
),
),
),

const CustomBottomNavBar(activeIndex: 0),
],
),
),
);
}
}
